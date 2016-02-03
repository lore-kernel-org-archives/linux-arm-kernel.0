From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 3 Feb 2016 08:56:35 +0100
Subject: [PATCH 1/3] ARM: move .vectors and .stubs sections back into the
 kernel VMA
In-Reply-To: <20160203000351.GX10826@n2100.arm.linux.org.uk>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454419174-21290-2-git-send-email-ard.biesheuvel@linaro.org>
 <20160203000351.GX10826@n2100.arm.linux.org.uk>
Message-ID: <CAKv+Gu_kYWczCazqgRC3y-n7s3WRTDhJXLO1RM1FE-6h1BhSUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 February 2016 at 01:03, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 02, 2016 at 02:19:32PM +0100, Ard Biesheuvel wrote:
>> The sections themselves are emitted 4 KB apart, as required:
>>   ...
>>   [16] .stubs       PROGBITS   c0c35000 a35000 0002c0 00  AX  0   0 32
>>   [17] .vectors     PROGBITS   c0c34000 a44000 000020 00  AX  0   0  2
>>   ...
>
> ... which means we end up wasting most of a page for absolutely no
> purpose what so ever.  Sorry, I'm really not happy about this
> gratuitous wastage.
>

No, we don't. Here's some more context:

Before:
  [14] .ARM.unwind_tab   PROGBITS        c0c2ef98 a2ef98 005088 00   A  0   0  4
  [15] .notes            NOTE            c0c34020 a34020 000024 00  AX  0   0  4
  [16] .vectors          PROGBITS        00000000 a40000 000020 00  AX  0   0  2
  [17] .stubs            PROGBITS        00001000 a41000 0002c0 00  AX  0   0 32
  [18] .init.text        PROGBITS        c0c352e0 a452e0 06b1b8 00  AX  0   0 32

After
  [14] .ARM.unwind_tab   PROGBITS        c0c2ef98 a2ef98 005088 00   A  0   0  4
  [15] .notes            NOTE            c0c34020 a34020 000024 00  AX  0   0  4
  [16] .stubs            PROGBITS        c0c35000 a35000 0002c0 00  AX  0   0 32
  [17] .vectors          PROGBITS        c0c34000 a44000 000020 00  AX  0   0  2
  [18] .init.text        PROGBITS        c0c352e0 a452e0 06b1b8 00  AX  0   0 32

As you can see, the LMA footprint has not increased, only .stubs and
.vectors have been reordered. The apparent rounding after the .notes
section occurs in both cases, and is due to the fact that __init_begin
is rounded to page size, and has nothing to do with the VMAs chosen
for the .stubs and .vectors section.

> We changed to the existing solution to get rid of the VMA offset
> to make the code easier to read, but if we're going to get rid of
> that improvement, just revert the change.  (Check the kernel history.)
>

I think that change was an improvement. It makes the code itself more
readable, but also results in correct references in the object files
rather than opaque expressions, i.e.,

  c0c34000 <.vectors>:
  c0c34000:       f001 b800       b.w     c0c35004 <vector_rst>
  c0c34004:       f001 b8cc       b.w     c0c351a0 <vector_und>
  c0c34008:       f8df fff4       ldr.w   pc, [pc, #4084] ; c0c35000
  c0c3400c:       f001 b888       b.w     c0c35120 <vector_pabt>
  c0c34010:       f001 b846       b.w     c0c350a0 <vector_dabt>
  c0c34014:       f001 b904       b.w     c0c35220 <vector_addrexcptn>
  c0c34018:       f001 b802       b.w     c0c35020 <vector_irq>
  c0c3401c:       f001 b910       b.w     c0c35240 <vector_fiq>

-- 
Ard.
