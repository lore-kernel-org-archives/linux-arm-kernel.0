From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Dec 2012 17:45:39 +0000
Subject: About the workaround for the 484863 L220 erratum
In-Reply-To: <4AE7B88EC8BA74469869BB7EEB7D66671BCA7C88@g01jpexmbyt23>
References: <4AE7B88EC8BA74469869BB7EEB7D66671BCA3685@g01jpexmbyt23>
 <20121204132950.GO23368@mudshark.cambridge.arm.com>
 <CAHkRjk7+EgN67VoJaS2e+PryJy-hyOx4-RJASzkLcaEidSLGxA@mail.gmail.com>
 <4AE7B88EC8BA74469869BB7EEB7D66671BCA7C88@g01jpexmbyt23>
Message-ID: <CAHkRjk6Uhj2T8KVzgow096WH+CcfxfaZ2JbbExt_11R6-wn1gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 December 2012 12:44, Asano, Yasushi <yasushi.asano@jp.fujitsu.com> wrote:
>> On 4 December 2012 13:29, Will Deacon <will.deacon@arm.com> wrote:
>> > On Tue, Dec 04, 2012 at 12:57:57PM +0000, Asano, Yasushi wrote:
>> >> I am looking for a workaround for the 484863 L220 erratum.
>> >> "484863: The Cache Sync operation does not guarantee that the Eviction
>> Buffer is empty"
>> >>
>> >> Then I found a patch as below.
>> >>
>> http://www.linux-arm.org/git?p=linux-2.6-stable.git;a=commitdiff;h=6
>> 1
>> >> f0ab1658f41f34c1910848063c565095a47864
>> ...
>> >> Could you please tell me if you know the reason why it does not get
>> into the mainline.
>> >
>> > Probably because, looking at the patch in question, it uses a swp
>> > instruction in the kernel which could be fatal if we have swp
>> > emulation enabled (we only emulate for user mode).
>>
>> Another reason I remember is that swp on that register caused hardware
>> deadlocks on some platforms. So the workaround is highly dependent on
>> the L2 wiring.
>
> Thank you so much for your prompt reply, Will and Catalin.
> I understood using a swp instruction is not stable for some platforms.
> That is the reason why it has not been merged into the mainline.
> However, I would like to know how to avoid this erratum.
> Could you please tell me if you know about another workaround.

It looks like the errata doc was update and states that the swp must
not target the PL220 peripheral port.

Anyway, the two workarounds listed in the doc are:

* Replace the Cache Sync operation by a dummy SWP to an L1
non-cacheable and L2 cacheable or non-cacheable memory area that will
go through one of the two main L220 slave ports (S0 or S1). The AXI
locked transactions received by these slave ports are only treated
once all buffers are empty, including the Eviction Buffer. This dummy
SWP must not target the L220 Peripheral port.

* Do a dummy STR to L1 and L2 Normal Memory Non-cacheable memory area
that will go into the L220 Write Buffer before launching the Cache
Sync operation. This guarantees that the last eviction resulting from
the clean operation has been written to L3 when the Cache Sync
operation completes.

-- 
Catalin
