From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 16 Jul 2013 10:45:08 +0100
Subject: [RFC PATCH v4 03/18] Documentation: devicetree: arm: cpus/cpu
 nodes bindings updates
In-Reply-To: <51E44486.7050806@gmail.com>
References: <1368804061-4421-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1368804061-4421-4-git-send-email-lorenzo.pieralisi@arm.com>
 <CAL_JsqLANi5UoVyRMsa6XoQ+_KnmTQDfTz++shEh-dZ3FQGZaQ@mail.gmail.com>
 <20130715093406.GC15904@e102568-lin.cambridge.arm.com>
 <51E44486.7050806@gmail.com>
Message-ID: <20130716094508.GA28503@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 07:50:46PM +0100, Rob Herring wrote:
> On 07/15/2013 04:34 AM, Lorenzo Pieralisi wrote:
> > On Fri, Jul 12, 2013 at 03:47:17PM +0100, Rob Herring wrote:
> >> On Fri, May 17, 2013 at 10:20 AM, Lorenzo Pieralisi
> >> <lorenzo.pieralisi@arm.com> wrote:
> >>> In order to extend the current cpu nodes bindings to newer CPUs
> >>> inclusive of AArch64 and to update support for older ARM CPUs this
> >>> patch updates device tree documentation for the cpu nodes bindings.
> >>
> >> Sorry for the long delay on this, but I'm still not happy with the binding here.
> > 
> > I had to ask Russell again to drop the bindings patches from the patch
> > system, and this is not acceptable since two months have passed and the
> > entire series was reviewed, acked and partially merged. I will review
> > these bindings again but I would like to understand who should give the final
> > go ahead to get these patches queued for upstreaming, I can't continue
> > updating this stuff forever.
> 
> Most of my comments are for 64-bit. So don't blame me that it had to be
> reverted. I said up front I was concerned about this change breaking
> things and it appears it did. New kernels must not require a new DT.

The patches in Russell's tree do not break anything, I asked him to drop
them since, if we change the bindings again, those patches change and have
to be reworked. It was not meant to blame you at all, just saying that
the process to get this stuff in the kernel should be defined properly
and patches reviewed in a timely fashion.

And for legacy reasons the situation related to cpu/cpus node bindings
is a complicated one, there are bindings in the ePAPR, bindings in the
kernel, people are confused and with this set we wanted to draw a
line. For arm64 this is an absolute must.

I disagree with you on the "new kernels must not require a new DT".
That's true if bindings are well defined, not for a mix of legacy ePAPR and
bindings-in-the-kernel.

What's the DT standard for ARM cpu/cpus node ? ePAPR ? In kernel docs ?
A combination thereof ? Things are not clear cut and I do not like that, it
is confusing.

> But yes, this should have been reviewed more quickly. We're working on a
> plan to help address DT binding reviews. We have not enforced that Grant
> and I must ack all bindings, but in this case you certainly need mine
> since I have reviewed it and if you want to me to pull it.

Good, that's all I wanted to know, thanks.

> >>> Main changes:
> >>>     - adds 64-bit bindings
> >>>     - define usage of #address-cells
> >>>     - define 32/64 dts compatibility settings
> >>>     - defines behaviour on pre and post v7 uniprocessor systems
> >>>     - adds ARM 11MPcore specific reg property definition
> >>>
> >>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/arm/cpus.txt | 459 ++++++++++++++++++++++---
> >>>  1 file changed, 412 insertions(+), 47 deletions(-)
> >>
> >> [snip]
> >>
> >>> +                       # On ARM v8 64-bit systems, where the reg property
> >>> +                         size can be 1 or 2 cells (as defined by cpus node's
> >>> +                         #address-cells property), this property is
> >>> +                         required and matches:
> >>> +
> >>> +                         - On systems running the OS in AArch32:
> >>
> >> The DTS cannot change based on 32-bit or 64-bit OS.
> > 
> > "On systems running the OS in AArch32" implies a dependency on the
> > HW execution state. Since the DT is used to configure OSs I thought that
> > could be a valid sentence. Unfortunately this stuff is not C, so I
> > reiterate my point above, before changing it I would like to understand
> > who should say the wording is ok otherwise we could argue forever.
> 
> It does configure the OS, but not for 32 vs. 64 bit. That is more of a
> problem for the bootloader to know which mode to boot in and covered
> under something like Documentation/arm/Booting. Booting ARM vs. Thumb
> mode would be similar situation.
> 
> Think about how your PC boots and add to that having a DTB as part of
> the firmware shipped with your PC. Then the end user can install a
> 32-bit or 64-bit OS on it. That is the usecase that needs to be
> supported and having different DTB for 32 and 64 bit is totally broken
> and doesn't even help solve that problem.

I will give it more thought, point taken.

> >>> +
> >>> +       - cpu-release-addr
> >>> +               Usage: required for systems that have an "enable-method"
> >>> +                      property value of "spin-table".
> >>> +               Value type: <prop-encoded-array>
> >>> +               Definition:
> >>> +                       # On ARM v8 64-bit systems must be a two cell
> >>> +                         property identifying a 64-bit zero-initialised
> >>> +                         memory location.
> >>
> >> As I mentioned previously, isn't some wake-up method needed? Most
> >> systems will be in wfi or wfe rather than continuously spinning.
> > 
> > Mmm...this can become a minefield, wfe, wfi, CPU in reset..this needs some
> > thought.
> 
> Yes, it is today and standardizing this is a good thing. Which is what
> PSCI does. So why are you adding the spintable at all? Are you trying to
> set this as the standard for non-PSCI enabled platforms? Why not just
> say v8 boot interface is PSCI. Sure, we'll probably have to deal with
> other methods, but documenting something else here is not going to
> prevent that problem. I don't think a simple spintable would even work
> for any/most current platforms. I'd think we'd want to define something
> that would work for existing platforms (chances are new platforms will
> work like vendors' existing 32-bit platforms).

"spin-table" is how the current v8 kernel boots, I am not adding
anything. It is documented in Documentation/arm64/booting.txt.
I have to add the possible wake-up method(s) to the definition of
spin-table here.

Just adding PSCI is tempting but not viable, that would make people
think that's the only allowed method and that's not acceptable.

While defining the process for the introduction of new DT bindings
please consider how we have to deal with legacy bindings designed for
PowerPC that people tend to reuse for ARM ("status" property in cpu
nodes is next, as James highlighted in another thread).

We are doing that in a case by case fashion and that's becoming a nightmare.

Thank you !
Lorenzo
