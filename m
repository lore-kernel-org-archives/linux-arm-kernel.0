From: bdegraaf@codeaurora.org (bdegraaf at codeaurora.org)
Date: Thu, 11 Aug 2016 15:39:11 -0400
Subject: [RFC] arm64: Enforce gettimeofday vdso structure read ordering
In-Reply-To: <20160811155409.GE8232@arm.com>
References: <20160811153744.3212-1-cov@codeaurora.org>
 <20160811155409.GE8232@arm.com>
Message-ID: <8375bf253e2f9034e5c5943e68876935@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, this is my first go at proper email etiquette. I think I've got 
it now.

------------------------------------------------------------------------------
"Can you explain the problem that you're fixing here, please?"
------------------------------------------------------------------------------
Since your question included only the vdso_data structure itself and the
vdso.c file changes, I'm assuming that's what you meant by "here."
I moved tb_seq_count to the start of the vdso_data structure because of 
the
nature of the ldar/strl instructions, which do not support offsets.
This avoided the extra math to locate the structure offset, while at the 
same
time using the same base pointer for the structure.  ia64 does something
similar and also puts this as the first field.  I moved the use_syscall
field up next to it just to keep most elements aligned according to 
their
width. That "use_syscall" is the first element used in the logic was an
additional reason I decided to move that one in particular.

--- a/arch/arm64/include/asm/vdso_datapage.h
+++ b/arch/arm64/include/asm/vdso_datapage.h
@@ -21,6 +21,8 @@
  #ifndef __ASSEMBLY__

  struct vdso_data {
+    __u32 tb_seq_count;    /* Timebase sequence counter */
+    __u32 use_syscall;
      __u64 cs_cycle_last;    /* Timebase at clocksource init */
      __u64 raw_time_sec;    /* Raw time */
      __u64 raw_time_nsec;
@@ -30,14 +32,12 @@ struct vdso_data {
      __u64 xtime_coarse_nsec;
      __u64 wtm_clock_sec;    /* Wall to monotonic time */
      __u64 wtm_clock_nsec;
-    __u32 tb_seq_count;    /* Timebase sequence counter */
      /* cs_* members must be adjacent and in this order (ldp accesses) 
*/
      __u32 cs_mono_mult;    /* NTP-adjusted clocksource multiplier */
      __u32 cs_shift;        /* Clocksource shift (mono = raw) */
      __u32 cs_raw_mult;    /* Raw clocksource multiplier */
      __u32 tz_minuteswest;    /* Whacky timezone stuff */
      __u32 tz_dsttime;
-    __u32 use_syscall;
  };

----------------------------------------------------------------------------
As to vdso.c, I changed the instructions used to access tb_seq_count 
(both
in vdso.c and the gettimeofday.S file) to the load-acquire/store-release
instructions because those instructions seem to be designed for this
particular scenario: their "one-way" barriers enforce the order we need,
on top of eliminating the explicit barriers.
----------------------------------------------------------------------------

--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -201,10 +201,12 @@ up_fail:
   */
  void update_vsyscall(struct timekeeper *tk)
  {
+    register u32 tmp;
      u32 use_syscall = strcmp(tk->tkr_mono.clock->name, 
"arch_sys_counter");

-    ++vdso_data->tb_seq_count;
-    smp_wmb();
+    tmp = smp_load_acquire(&vdso_data->tb_seq_count);
+    ++tmp;
+    smp_store_release(&vdso_data->tb_seq_count, tmp);

"This looks busted -- the writes to vdso_data can be reordered before 
the
update of tb_seq_count.

/confused

Will"

--------------------------------------------------------------------------

Hopefully, this more detailed explanation helps make things clearer.

Thank you,
Brent
