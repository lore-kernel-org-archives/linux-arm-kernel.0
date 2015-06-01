From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 1 Jun 2015 12:46:27 +0200
Subject: [PATCH 1/8] of/fdt: split off FDT self reservation from
 memreserve processing
In-Reply-To: <20150601095655.GB22406@leverpostej>
References: <1431326520-17331-1-git-send-email-ard.biesheuvel@linaro.org>
 <1431326520-17331-2-git-send-email-ard.biesheuvel@linaro.org>
 <20150522103541.GU29424@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8-av3xTTf=YHAmU2TBuQrBWAS4WBLwK9hfgZbX0YH89A@mail.gmail.com>
 <20150601095655.GB22406@leverpostej>
Message-ID: <CAKv+Gu-FM-RGiavw6m599uyBBpCCPT1Wn6WNko46wozRONv6vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 June 2015 at 11:56, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Jun 01, 2015 at 08:56:07AM +0100, Ard Biesheuvel wrote:
>> (snip non-LAKML CCs)
>>
>> On 22 May 2015 at 12:35, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > On Mon, May 11, 2015 at 08:41:53AM +0200, Ard Biesheuvel wrote:
>> >> This splits off the reservation of the memory occupied by the FDT
>> >> binary itself from the processing of the memory reservations it
>> >> contains. This is necessary because the physical address of the FDT,
>> >> which is needed to perform the reservation, may not be known to the
>> >> FDT driver core, i.e., it may be mapped outside the linear direct
>> >> mapping, in which case __pa() returns a bogus value.
>> >>
>> >> Cc: Russell King <linux@arm.linux.org.uk>
>> >> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> >> Cc: Paul Mackerras <paulus@samba.org>
>> >> Acked-by: Rob Herring <robh@kernel.org>
>> >> Acked-by: Mark Rutland <mark.rutland@arm.com>
>> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >
>> > For the arm64 part:
>> >
>> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>>
>> Thanks Catalin,
>>
>> Since there has been virtually no discussion about these patches, I
>> guess they have missed the window for being considered for inclusion
>> in v4.2
>>
>> May I suggest that you at least consider these patches regarding the ID map
>>
>> http://article.gmane.org/gmane.linux.ports.arm.kernel/411720
>> http://article.gmane.org/gmane.linux.ports.arm.kernel/411721
>>
>> since they are self-contained and the first one does fix a potential
>> problem where the Image placement logic in the stub does not take the
>> 512 MB alignment boundary into account. The second one is a trivial
>> cleanup.
>
> FWIW both of these look good to me.
>
>> Perhaps Mark can comment on the desirability to include the FDT
>> remapping patch (which depends on this 1/8).
>>
>> http://article.gmane.org/gmane.linux.kernel.efi/5738
>
> I would like to see that taken if possible.
>

Thanks.

Actually, it does make kind of sense to take these four (i.e., this
1/8 plus the three referenced above) patches as a set, since together
they address all the known shortcomings in the EFI stub regarding the
placement of both the FDT and the kernel image. All the other stuff
can easily be deferred.

I will respin these 4 with the new tags added.
