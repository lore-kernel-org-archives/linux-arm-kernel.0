From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 31 Jul 2011 01:37:46 +0200
Subject: [PATCH 04/18] dmaengine/amba-pl08x: Remove redundant comment and
	rewrite original
In-Reply-To: <20110730225708.GB17570@n2100.arm.linux.org.uk>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<e2c1bd6941e88f8988b1942c13c20cf436b3a963.1311936524.git.viresh.kumar@st.com>
	<1311941355.1536.529.camel@vkoul-udesk3>
	<CAOh2x=kqa0GxRH9o=8faPhuyyLcqxH8+AOowBTK_gMaDgJyeVA@mail.gmail.com>
	<CAKnu2MrWbm5w6QsBzj=Fd=f7SfE=4_7bHMBBdQiN2bCnbeV-eg@mail.gmail.com>
	<20110730225708.GB17570@n2100.arm.linux.org.uk>
Message-ID: <CAKnu2MpzFK1HHhs7F5PV1EsbCG9y1Htbu5KM7x0OC2_9U=vovA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/31 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sun, Jul 31, 2011 at 12:32:55AM +0200, Linus Walleij wrote:
>> The PL08x has two bus mastering interfaces. They can be
>> connected to two separate busses and two adress spaces
>> even, usually that is not the case though.
>
> This is not what the function is about... that's done by my
> pl08x_select_bus() function.

To be clear, I was explaining what I percieved as a
question from Viresh about what the comment in this hunk of
the patch was about:

@@ -498,9 +498,9 @@ struct pl08x_lli_build_data {
};
 /*
- * Autoselect a master bus to use for the transfer this prefers the
- * destination bus if both available if fixed address on one bus the
- * other will be chosen
+ * Autoselect a master bus to use for the transfer
+ * - prefers the destination bus if both available
+ * - if fixed address on one bus the other will be chosen
 */
 static void pl08x_choose_master_bus(struct pl08x_lli_build_data *bd,
       struct pl08x_bus_data **mbus, struct pl08x_bus_data **sbus, u32 cctl)

This is the comment just above pl08x_choose_master_bus(),
the pl08x_lli_build_data() just has a danglig semicolon in the hunk.

As for the LLI code, all of it's weird complexity comes from the fact
that the DMAC cannot let a single element pass across 1KB (0x400)
boundaries, which is one more than a little insane hardware
restriction, and I have no clue where that limitation actually comes
from, likely strange VHDL code.

Then for this hunk:

@@ -626,11 +626,6 @@ static int pl08x_fill_llis_for_desc(struct
pl08x_driver_data *pl08x,
       /* We need to count this down to zero */
       bd.remainder = txd->len;

-       /*
-        * Choose bus to align to
-        * - prefers destination bus if both available
-        * - if fixed address on one bus chooses other
-        */
       pl08x_choose_master_bus(&bd, &mbus, &sbus, cctl);

This is I think just redundant commenting of what the called function does,
so yes should be deleted.

Thanks,
Linus Walleij
