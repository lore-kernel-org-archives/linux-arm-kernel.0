From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Dec 2013 17:09:11 +0000
Subject: [PATCH] arm64 ptrace.c
In-Reply-To: <CAAXgzBMC20L9TqjAV_Q=XZpsgczk5isBou2wqs6vfXun6P1Bfw@mail.gmail.com>
References: <CAAXgzBO1TF=_EdkUieuyf1fbUYx9FVWExqGSi3CcUip7eboMAw@mail.gmail.com>
 <20131210111445.GF2338@mudshark.cambridge.arm.com>
 <CAAXgzBMC20L9TqjAV_Q=XZpsgczk5isBou2wqs6vfXun6P1Bfw@mail.gmail.com>
Message-ID: <20131211170911.GH26730@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 07:16:11AM +0000, Aaron Liu wrote:
> Hi Will,

Hi Aaron,

> gdb calls ptrace twice to set watch points and break points as
> following. After first ptrace call is completed, second ptrace call
> fails with no space error. The first ptrace will reserve 16 watch
> points in static LIST_HEAD(bp_task_head)@kernel/events/hw_breakpoint.c
> and each entry, ie. struct perf_event, has a member called
> attr.bp_type. The bp_type in the entry should be used as indicator for
> watch points or break points. You could see
> __reserve_bp_slot at kernel/events/hw_breakpoint.c and find it does a
> basic check bp_type should be not HW_BREAKPOINT_EMPTY and
> HW_BREAKPOINT_INVALID. After the __reserve_bp_slot call, the reserved
> slot's bp_type is HW_BREAKPOINT_RW or HW_BREAKPOINT_X. However,
> ptrace_hbp_fill_attr_ctrl at arch/arm64/kernel/ptrace.c set the bp_type
> to HW_BREAKPOINT_EMPTY if it's disabled. This causes the
> find_slot_idx at kernel/event/hw_breakpoint.c to judge the existing
> entries as TYPE_INST. So, after first 16 watch points are reserved in
> list, the following break points determine no space to reserve, ie.
> max 16 break points. The patch only set disable bit even user zeroing
> control bits and it could still pass
> modify_user_hw_breakpoint at kernel/events/hw_breakpoint.c.

Ok, thanks for the explanation. This used to work, but I suspect something
changed in the core code which caused this to start breaking with
HW_BREAKPOINT_EMPTY.

Lucky for us, our ptrace_hbp_create function will infer the type/len for us
using values that are known to pass validation. In that case, the use of
HW_BREAKPOINT_EMPTY is redundant -- we just need to make sure we avoid
populating anything other than the disabled field in the perf_event_attr.

A curious behaviour here (which also exists in the current code) is that the
breakpoint register effectively becomes read-only apart from the enable bit
if you are disabling it. That shouldn't effect gdb, though, and is required
to allow nuking of the breakpoint without changing its type.

Can you test the following patch please?

Thanks,

Will

--->8

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6777a2192b83..6a8928bba03c 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -214,31 +214,29 @@ static int ptrace_hbp_fill_attr_ctrl(unsigned int note_type,
 {
 	int err, len, type, disabled = !ctrl.enabled;
 
-	if (disabled) {
-		len = 0;
-		type = HW_BREAKPOINT_EMPTY;
-	} else {
-		err = arch_bp_generic_fields(ctrl, &len, &type);
-		if (err)
-			return err;
-
-		switch (note_type) {
-		case NT_ARM_HW_BREAK:
-			if ((type & HW_BREAKPOINT_X) != type)
-				return -EINVAL;
-			break;
-		case NT_ARM_HW_WATCH:
-			if ((type & HW_BREAKPOINT_RW) != type)
-				return -EINVAL;
-			break;
-		default:
+	attr->disabled = disabled;
+	if (disabled)
+		return 0;
+
+	err = arch_bp_generic_fields(ctrl, &len, &type);
+	if (err)
+		return err;
+
+	switch (note_type) {
+	case NT_ARM_HW_BREAK:
+		if ((type & HW_BREAKPOINT_X) != type)
 			return -EINVAL;
-		}
+		break;
+	case NT_ARM_HW_WATCH:
+		if ((type & HW_BREAKPOINT_RW) != type)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
 	}
 
 	attr->bp_len	= len;
 	attr->bp_type	= type;
-	attr->disabled	= disabled;
 
 	return 0;
 }
