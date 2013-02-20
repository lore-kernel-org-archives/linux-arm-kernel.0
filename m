From: js@sig21.net (Johannes Stezenbach)
Date: Wed, 20 Feb 2013 15:56:54 +0100
Subject: [PATCH] ARM: decompressor: clear SCTLR.A bit for v7 cores
In-Reply-To: <CANLjY-k7sn-7pH_0nFiktXCxvgy8XizVbPRvS8aG1rg+CmVTPQ@mail.gmail.com>
References: <1349959402-24164-1-git-send-email-robherring2@gmail.com>
 <20121025093411.GA32662@sig21.net> <50893389.2090002@gmail.com>
 <20121025141645.GA16962@sig21.net> <50894BC2.5050706@gmail.com>
 <20121025150816.GA3874@sig21.net>
 <20121105104839.GA2005@linaro.org>
 <20121105111346.GF28327@n2100.arm.linux.org.uk>
 <5097C3B5.4080406@gmail.com>
 <CANLjY-k7sn-7pH_0nFiktXCxvgy8XizVbPRvS8aG1rg+CmVTPQ@mail.gmail.com>
Message-ID: <20130220145654.GA6742@sig21.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replying to old thread, for full context see
http://thread.gmane.org/gmane.linux.ports.arm.kernel/180226/focus=197914

On Tue, Nov 06, 2012 at 11:02:27AM +1300, Michael Hope wrote:
> On 6 November 2012 02:48, Rob Herring <robherring2@gmail.com> wrote:
> >
> > I tried adding -munaligned-accesses on a v6 build and still get byte
> > accesses rather than unaligned word accesses. So this does seem to be a
> > v7 only issue based on what gcc will currently produce. Copying Michael
> > Hope who can hopefully provide some insight on why v6 unaligned accesses
> > are not enabled.
> 
> This looks like a bug.  Unaligned access is enabled for armv6 but
> seems to only take effect for cores with Thumb-2.  Here's a test case
> both with unaligned field access and unaligned block copy:
> 
> struct foo
> {
>   char a;
>   int b;
>   struct
>   {
>     int x[3];
>   } c;
> } __attribute__((packed));
> 
> int get_field(struct foo *p)
> {
>   return p->b;
> }
> 
> int copy_block(struct foo *p, struct foo *q)
> {
>   p->c = q->c;
> }
> 
> With -march=armv7-a you get the correct:
> 
> bar:
> 	ldr	r0, [r0, #1]	@ unaligned	@ 11	unaligned_loadsi/2	[length = 4]
> 	bx	lr	@ 21	*arm_return	[length = 12]
> 
> baz:
> 	str	r4, [sp, #-4]!	@ 25	*push_multi	[length = 4]
> 	mov	r2, r0	@ 2	*arm_movsi_vfp/1	[length = 4]
> 	ldr	r4, [r1, #5]!	@ unaligned	@ 9	unaligned_loadsi/2	[length = 4]
> 	ldr	ip, [r1, #4]	@ unaligned	@ 10	unaligned_loadsi/2	[length = 4]
> 	ldr	r1, [r1, #8]	@ unaligned	@ 11	unaligned_loadsi/2	[length = 4]
> 	str	r4, [r2, #5]	@ unaligned	@ 12	unaligned_storesi/2	[length = 4]
> 	str	ip, [r2, #9]	@ unaligned	@ 13	unaligned_storesi/2	[length = 4]
> 	str	r1, [r2, #13]	@ unaligned	@ 14	unaligned_storesi/2	[length = 4]
> 	ldmfd	sp!, {r4}
> 	bx	lr
> 
> With -march=armv6 you get a byte-by-byte field access and a correct
> unaligned block copy:
> 
> bar:
> 	ldrb	r1, [r0, #2]	@ zero_extendqisi2
> 	ldrb	r3, [r0, #1]	@ zero_extendqisi2
> 	ldrb	r2, [r0, #3]	@ zero_extendqisi2
> 	ldrb	r0, [r0, #4]	@ zero_extendqisi2
> 	orr	r3, r3, r1, asl #8
> 	orr	r3, r3, r2, asl #16
> 	orr	r0, r3, r0, asl #24
> 	bx	lr
> 
> baz:
> 	str	r4, [sp, #-4]!
> 	mov	r2, r0
> 	ldr	r4, [r1, #5]!	@ unaligned
> 	ldr	ip, [r1, #4]	@ unaligned
> 	ldr	r1, [r1, #8]	@ unaligned
> 	str	r4, [r2, #5]	@ unaligned
> 	str	ip, [r2, #9]	@ unaligned
> 	str	r1, [r2, #13]	@ unaligned
> 	ldmfd	sp!, {r4}
> 	bx	lr
> 
> readelf -A shows that the compiler planned to use unaligned access in
> both.  My suspicion is that GCC is using the extv pattern to extract
> the field from memory, and that pattern is only enabled for Thumb-2
> capable cores.
> 
> I've logged PR55218.  We'll discuss it at our next meeting.

Just tried with gcc-linaro-4.7-2013.01 (gcc-4.7.3 20130102 (prerelease)),
the issue is still unfixed.  Do you have any idea how to fix it?
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=55218

Thanks,
Johannes
