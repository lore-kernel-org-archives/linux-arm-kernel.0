From: ccross@android.com (Colin Cross)
Date: Sun, 20 Feb 2011 10:43:15 -0800
Subject: [PATCH v2] ARM: vfp: Always save VFP state in vfp_pm_suspend
In-Reply-To: <20110220125745.GC14495@n2100.arm.linux.org.uk>
References: <AANLkTik_Jey_PtRmr530FVckA6RXHESeX+CyoJC=ZTkR@mail.gmail.com>
	<1297724147-6320-1-git-send-email-ccross@android.com>
	<20110215170336.GP4152@n2100.arm.linux.org.uk>
	<AANLkTim4ANuErvT4c5mBnu+Yg5m9sz6N8xugryXRJeN7@mail.gmail.com>
	<20110220125745.GC14495@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikiEUFgMd8zpVVOEaZexOuV-KcGhACpUTZMGQKr@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 20, 2011 at 4:57 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Feb 16, 2011 at 11:36:45AM -0800, Colin Cross wrote:
>> On Tue, Feb 15, 2011 at 9:03 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Mon, Feb 14, 2011 at 02:55:47PM -0800, Colin Cross wrote:
>> >> diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
>> >> index 66bf8d1..7231d18 100644
>> >> --- a/arch/arm/vfp/vfpmodule.c
>> >> +++ b/arch/arm/vfp/vfpmodule.c
>> >> @@ -415,13 +415,13 @@ static int vfp_pm_suspend(struct sys_device *dev, pm_message_t state)
>> >> ? ? ? struct thread_info *ti = current_thread_info();
>> >> ? ? ? u32 fpexc = fmrx(FPEXC);
>> >>
>> >> - ? ? /* if vfp is on, then save state for resumption */
>> >> - ? ? if (fpexc & FPEXC_EN) {
>> >> + ? ? /* save state for resume */
>> >> + ? ? if (last_VFP_context[ti->cpu]) {
>> >
>> > I'm not entirely happy with this.
>> >
>> > It is true that last_VFP_context[] when non-NULL indicates who owns the
>> > hardware VFP state, so saving it would seem logical. ?However, this new
>> > code now saves the state with the saved fpexc indicating that it's disabled.
>> >
>> > This will cause a VFP exception to misbehave by reloading the state, and
>> > then disabling the VFP unit. ?That will cause another VFP exception which
>> > will find the VFP unit disabled, and re-enable it. ?All in all, this is
>> > rather wasteful.
>> >
>> > So...
>> > ? ? ? ?/* If lazy disable, re-enable the VFP ready for it to be saved */
>> > ? ? ? ?if (last_VFP_context[ti->cpu] != &ti->vfpstate) {
>> > ? ? ? ? ? ? ? ?fpexc |= FPEXC_EN;
>> > ? ? ? ? ? ? ? ?fmxr(FPEXC, fpexc);
>> > ? ? ? ?}
>> > ? ? ? ?/* If VFP is on, then save state for resumption */
>> > ? ? ? ?if (fpexc & FPEXC_EN) {
>> > ? ? ? ? ? ? ? ?...
>>
>> I think v2 of the patch handles this case correctly:
>> ? ? ? /* save state for resume */
>> ? ? ? if (last_VFP_context[ti->cpu]) {
>> ? ? ? ? ? ? ? printk(KERN_DEBUG "%s: saving vfp state\n", __func__);
>> ? ? ? ? ? ? ? fmxr(FPEXC, fpexc | FPEXC_EN);
>> ? ? ? ? ? ? ? vfp_save_state(last_VFP_context[ti->cpu], fpexc);
>
> This saves fpexc with the enable flag possibly clear.
>
>> ? ? ? ? ? ? ? last_VFP_context[ti->cpu] = NULL;
>> ? ? ? ? ? ? ? fmxr(FPEXC, fpexc & ~FPEXC_EN);
>> ? ? ? }
>>
>> This version enables the VFP if it was not enabled, but saves the
>> original fpexc value.
>
> Which is wrong as I said above.
>

Sorry, I misunderstood.  I'll repost with your changes after I get a
chance to test it, or you can commit it yourself.
