From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 16 Feb 2017 18:52:15 +0900
Subject: [PATCH v32 07/13] arm64: hibernate: preserve kdump image around
 hibernation
In-Reply-To: <58A445B3.4080608@arm.com>
References: <20170207080601.5816-1-takahiro.akashi@linaro.org>
 <20170207080904.5974-5-takahiro.akashi@linaro.org>
 <58A445B3.4080608@arm.com>
Message-ID: <20170216095214.GF18445@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 12:12:35PM +0000, James Morse wrote:
> Hi Akashi,
> 
> On 07/02/17 08:08, AKASHI Takahiro wrote:
> > Since arch_kexec_protect_crashkres() removes a mapping for crash dump
> > kernel memory, the loaded contents won't be preserved around hibernation.
> > 
> > In this patch, arch_kexec_(un)protect_crashkres() are additionally called
> > before/after hibernation so that the relevant region will be mapped again
> > and restored just as the other memory regions are.
> 
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you very much.

> A quick test of this took longer than expected (writing to a slow usb device),

Really? I use a uSD card on hikey as a swap device, and it takes just
a few moments to save a hibernate image although I do the test right after
the system comes up.

> I
> suspect it is save/restoring the whole crash region (which I don't think is a
> problem).

Now that we have only page-level mappings for the crash region,
it might be possible to mark all the unused pages "reserved"
in arch_kexec_unprotect_crashkres() if called in hibernate.

-Takahiro AKASHI

> If someone turns out to use this combination of features I will look
> at improving this, (almost certainly requires core-code changes).
> 
> 
> Thanks,
> 
> James
