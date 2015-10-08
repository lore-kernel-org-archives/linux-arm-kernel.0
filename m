From: will.deacon@arm.com (Will Deacon)
Date: Thu, 8 Oct 2015 11:07:24 +0100
Subject: [PATCH] arm64: errata: add module build workaround for erratum
 #843419
In-Reply-To: <CALdTtnsSeWJxnJwhReWGmW9g7APo52p88UNpu59nNYqgW3fmag@mail.gmail.com>
References: <1442402197-20306-1-git-send-email-will.deacon@arm.com>
 <CALdTtnsyNeiRnqSdH6K1eHZ3KbAu02bqYCbnd7zWPGDjgGY8Ww@mail.gmail.com>
 <CAKv+Gu-srNtMq-DUJS1JrYuNwmV3Ku4+DvbR5e5QH39+3DA_cA@mail.gmail.com>
 <CALdTtnsSeWJxnJwhReWGmW9g7APo52p88UNpu59nNYqgW3fmag@mail.gmail.com>
Message-ID: <20151008100723.GB16807@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 12:07:54AM -0600, Dann Frazier wrote:
> On Tue, Oct 6, 2015 at 4:29 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > On 6 October 2015 at 22:44, Dann Frazier <dann.frazier@canonical.com> wrote:
> >> On Wed, Sep 16, 2015 at 5:16 AM, Will Deacon <will.deacon@arm.com> wrote:
> >>> Cortex-A53 processors <= r0p4 are affected by erratum #843419 which can
> >>> lead to a memory access using an incorrect address in certain sequences
> >>> headed by an ADRP instruction.
> >>
> >> Just a heads up that we're seeing a regression in the Ubuntu 4.2 kernel on
> >> X-Gene after this patch is applied and the CONFIG enabled.
> >>
> >> Modules loads fail with messages like:
> >>
> >> [ 2.192721] module gpio_xgene_sb: unsupported RELA relocation: 275
> >> [ 2.193609] module xgene_enet: unsupported RELA relocation: 275
> >> [ 2.249402] module libahci: unsupported RELA relocation: 275
> >> [ 2.249628] module xgene_enet: unsupported RELA relocation: 275
> >> [ 2.359451] module xgene_enet: unsupported RELA relocation: 275
> >> [ 2.389444] module xgene_enet: unsupported RELA relocation: 275
> >> [ 3.473766] module linear: unsupported RELA relocation: 275
> >> [ 3.543252] module multipath: unsupported RELA relocation: 275
> >> [ 3.593268] module raid0: unsupported RELA relocation: 275
> >> [ 3.663695] module raid1: unsupported RELA relocation: 275
> >> [ 3.713964] module raid6_pq: unsupported RELA relocation: 275
> >> [ 3.763983] module raid6_pq: unsupported RELA relocation: 275
> >> [ 3.803975] module raid6_pq: unsupported RELA relocation: 275
> >> [ 3.853881] module raid10: unsupported RELA relocation: 275
> >> [ 3.924962] module raid6_pq: unsupported RELA relocation: 275
> >>
> >
> > RELA #275 is the relocation against ADRP instructions, which GCC
> > should not emit anymore when -mcmodel=large is in effect.
> >
> > Can you confirm that the modules have been rebuilt with this config as
> > well?
> 
> Yeah, it was.
> 
> > Can you double check the GCC command line (with V=1) when doing
> > 'make modules' to ensure that '-mcmodel=large' is being passed?
> 
> I did, and I don't see -mcmodel at all. On a whim I changed
> CFLAGS_MODULE in the patch to KBUILD_CFLAGS_MODULE, and V=1 now shows
> -mcmodel=large. I haven't had time yet to figure out why the KBUILD
> variant is important, nor time to boot test such a build (travel day).

CFLAGS_MODULE is the environment variable (i.e. you can set it on the
cmdline), so we probably *should* be using KBUILD_CFLAGS_MODULE here
instead (and the thumb2 gas issue on arch/arm/ should be updated as
well).

However, I'd still like to understand how it's getting clobbered for
you. Are you overriding CFLAGS_MODULE someplace?

Will
