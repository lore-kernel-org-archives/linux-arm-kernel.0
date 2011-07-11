From: ccross@android.com (Colin Cross)
Date: Mon, 11 Jul 2011 12:38:17 -0700
Subject: [RFC PATCH 05/17] ARM: kernel: save/restore kernel IF
In-Reply-To: <20110711191952.GC8486@n2100.arm.linux.org.uk>
References: <1310053830-23779-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1310053830-23779-6-git-send-email-lorenzo.pieralisi@arm.com>
	<alpine.DEB.2.00.1107081641280.2609@localhost6.localdomain6>
	<20110711140047.GA346@e102568-lin.cambridge.arm.com>
	<20110711184010.GB8486@n2100.arm.linux.org.uk>
	<CAMbhsRRm4-8gzjxqqu8MAkyMg8Xx02wDhmjET0b9njVF5z=UVw@mail.gmail.com>
	<20110711191952.GC8486@n2100.arm.linux.org.uk>
Message-ID: <CAMbhsRTEif6ut8FzNS3Ur74pC7wQuWQMDNsG3zGwHZ7Dp6hT-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2011 at 12:19 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jul 11, 2011 at 11:51:00AM -0700, Colin Cross wrote:
>> On Mon, Jul 11, 2011 at 11:40 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Mon, Jul 11, 2011 at 03:00:47PM +0100, Lorenzo Pieralisi wrote:
>> >> Well, short answer is no. On SMP we do need to save CPU registers
>> >> but if just one single cpu is shutdown L2 is still on.
>> >> cpu_suspend saves regs on the stack that has to be cleaned from
>> >> L2 before shutting a CPU down which make things more complicated than
>> >> they should.
>> >
>> > Hang on. ?Please explain something to me here. ?You've mentioned a few
>> > times that cpu_suspend() can't be used because of the L2 cache. ?Why
>> > is this the case?
>> >
>> > OMAP appears to have code in its sleep path - which has been converted
>> > to cpu_suspend() support - to deal with the L2 issues.
>>
>> OMAP is very different, because it doesn't use cpu_suspend. ?It saves
>> it's state to SAR ram, which is mapped uncached, which avoids L2
>> problems.
>
> I'm afraid your information is out of date. ?See:

Oops, you're right - I'm working with a TI branch that has OMAP4
cpuidle support, which has not been converted.

> http://ftp.arm.linux.org.uk/git/?p=linux-2.6-arm.git;a=commitdiff;h=076f2cc449188b7d3d4866730afa3ac7be3e6640;hp=2637ce30e145557bf89ebcf35b2d78e729e16e5a
>
> ?arch/arm/mach-omap2/pm34xx.c ? ?| ? 47 +++----------
> ?arch/arm/mach-omap2/sleep34xx.S | ?143 +--------------------------------------
> ?2 files changed, 13 insertions(+), 177 deletions(-)
>
> for the trivial conversion, and:
>
> http://ftp.arm.linux.org.uk/git/?p=linux-2.6-arm.git;a=commit;h=46e130d298a384b677426e19faec311749ff2677
>
> ?arch/arm/mach-omap2/pm.h ? ? ? ?| ? 20 ++-
> ?arch/arm/mach-omap2/pm34xx.c ? ?| ? 20 ++--
> ?arch/arm/mach-omap2/sleep34xx.S | ?303 ++++++++++++++++++++++----------------
> ?arch/arm/plat-omap/sram.c ? ? ? | ? 15 +--
> ?4 files changed, 206 insertions(+), 152 deletions(-)
>
> for the cleanup of the SRAM code, most of which was found not to need
> being in SRAM. ?That's all tested as working (see the tested-by's) on
> a range of OMAP3 platforms.
>
> The whole series is at:
>
> http://ftp.arm.linux.org.uk/git/?p=linux-2.6-arm.git;a=shortlog;h=refs/heads/suspend
>
> There is only one currently merged SoC which hasn't been converted:
> shmobile. ?That's in progress, and there may already be patches for it.
> There's no blockers on that as far as I know other than availability of
> time.
>
>> The sleep_save_sp location also needs to be cleaned.
>
> Right.
>
>> > In the resume initial code:
>> >
>> > - If L2 state was lost, the L2 configuration needs to be restored.
>> > ?This generally needs to happen before cpu_resume is called:
>> > ?- there are CPUs which need L2 setup before the MMU is enabled.
>> > ?- OMAP3 currently does this in its assembly, which is convenient to
>> > ? ?allow it to make the SMI calls to the secure world. ?The same will
>> > ? ?be true of any CPU running in non-secure mode.
>> >
>> > - If L2 state was not lost, and the platform choses not to clean and
>> > ?invalidate the ABI registers from the stack, and the platform restores
>> > ?the L2 configuration before calling cpu_resume, then the ABI registers
>> > ?will be read out of L2 on return if that's where they are - at that
>> > ?point everything will be setup correctly.
>> >
>> > ?This will give the greatest performance, which is important for CPU
>> > ?idle use of these code paths.
>> >
>> > Now, considering SMP, there's an issue here: do we know at the point
>> > where one CPU goes down whether L2 state will be lost?
>>
>> CPU idle will need a voting mechanism between the two CPUs, and the
>> second CPU to go down needs to determine the minimum state supported
>> by both CPUs. ?Any time a CPU goes down, we should know for sure that
>> either the L2 will not be lost, or the L2 might be lost if the other
>> CPU goes idle.
>
> No it doesn't. ?As I've said: L2 is shared between the two CPUs.
>
> If L2 state is preserved, then the only thing that needs cleaning from
> L2 is the state which must be accessible to bring the system back up,
> which is the CPU specific state, the cpu_suspend state and the
> sleep_save_sp store.
>
> If L2 state is lost, the _first_ CPU to go down in a two-CPU system
> must do as above. ?If nothing else happens L2 state will be preserved.
> So there's absolutely no point what so ever the first CPU cleaning the
> entire L2 state - the second CPU will still be scribbling into L2 at
> that point.
>
> However, when the second CPU goes down, that's when the L2 state would
> need to be preserved if the L2.
>
> So, let's recap. ?In a two CPU system, when precisely one CPU goes into
> sleep mode, only the minimum L2 state needs cleaning. ?Nothing else.
> Only when the second CPU goes down does it matter whether L2 state needs
> to be preserved by cleaning or not because that is when L2 data loss
> may occur.

Sorry, I was confusing cleaning state from L2 with cleaning the whole
L2.  The first cpu always needs to clean its saved state from L2, the
second cpu might need to clean the whole L2.

>> In practice, I don't think many SoCs will support low power modes that
>> lose the L2 during idle, only during suspend. ?Tegra and OMAP4 both
>> don't support the modes where the L2 is powered down in idle.
>
> That's good, that means less to worry about. ?For idle, all we need to
> care about is the CPU specific state, the cpu_suspend state and the
> sleep_save_sp store. ?Great, that means things can be even simpler -
> cpu_suspend() just needs to know whether we're calling it because of
> idle, or whether we're calling it because of system suspend.
>
