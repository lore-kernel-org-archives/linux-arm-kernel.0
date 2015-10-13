From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 13 Oct 2015 14:52:00 +0200
Subject: [PATCH 3/3] fpga manager: Adding FPGA Manager support for Xilinx
 Zynq 7000
In-Reply-To: <561C979B.6040201@topic.nl>
References: <1444344307-22509-1-git-send-email-moritz.fischer@ettus.com>
 <1444344307-22509-4-git-send-email-moritz.fischer@ettus.com>
 <20151009163336.GM10631@jcartwri.amer.corp.natinst.com>
 <CAAtXAHea7GZDLez5kYas2PFQ-=KmS_on8WxFDCuvVb4Nh05a_w@mail.gmail.com>
 <561B9687.1070103@xilinx.com> <561BA60C.6010106@topic.nl>
 <561BA9C7.6070003@xilinx.com> <561C979B.6040201@topic.nl>
Message-ID: <561CFE70.1010508@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/13/2015 07:33 AM, Mike Looijmans wrote:
> On 12-10-15 14:38, Michal Simek wrote:
>> Hi Mike,
>>
>> On 10/12/2015 02:22 PM, Mike Looijmans wrote:
>>> On 12-10-15 13:16, Michal Simek wrote:
>>>>
>>>>>>> +static int zynq_fpga_ops_write(struct fpga_manager *mgr,
>>>>>>> +                            const char *buf, size_t count)
>>>>>>> +{
>>>>>>> +     struct zynq_fpga_priv *priv;
>>>>>>> +     int err;
>>>>>>> +     char *kbuf;
>>>>>>> +     size_t i, in_count;
>>>>>>> +     dma_addr_t dma_addr;
>>>>>>> +     u32 transfer_length = 0;
>>>>>>> +     bool endian_swap = false;
>>>>>>> +
>>>>>>> +     in_count = count;
>>>>>>> +     priv = mgr->priv;
>>>>>>> +
>>>>>>> +     kbuf = dma_alloc_coherent(priv->dev, count, &dma_addr,
>>>>>>> GFP_KERNEL);
>>>>>>> +     if (!kbuf)
>>>>>>> +             return -ENOMEM;
>>>>>>> +
>>>>>>> +     memcpy(kbuf, buf, count);
>>>>>>> +
>>>>>>> +     /* look for the sync word */
>>>>>>> +     for (i = 0; i < count - 4; i++) {
>>>>>>> +             if (memcmp(kbuf + i, "\x66\x55\x99\xAA", 4) == 0) {
>>>>>>> +                     dev_dbg(priv->dev, "Found normal sync
>>>>>>> word\n");
>>>>>>> +                     endian_swap = false;
>>>>>>> +                     break;
>>>>>>> +             }
>>>>
>>>> This is bin format
>>>>
>>>>>>> +             if (memcmp(kbuf + i, "\xAA\x99\x55\x66", 4) == 0) {
>>>>>>> +                     dev_dbg(priv->dev, "Found swapped sync
>>>>>>> word\n");
>>>>>>> +                     endian_swap = true;
>>>>>>> +                     break;
>>>>>>> +             }
>>>>
>>>> This is bit format from header
>>>>
>>>>>>> +     }
>>>>>>
>>>>>> How much control do we have over mandating the format of firmware at
>>>>>> this point?  It'd be swell if we could just mandate a specific
>>>>>> endianness, and leave this munging to usermode.
>>>>>
>>>>> That's a good question. Personally I do only care about one of both,
>>>>> but that's just because I get to decide for my targets...
>>>>> Opinions from the Xilinx guys?
>>>>
>>>> Don't know full history about this but in past bitstream in BIT format
>>>> was used. Which is header (partially decoding in u-boot for example)
>>>> with data.
>>>> On zynq native format is BIN which is format without header and data is
>>>> swapped.
>>>> This code just detects which format is used. If BIT, header is skipped
>>>> and data is swapped to BIN format.
>>>>
>>>> Back to origin question if this is something what can be handled from
>>>> user space. And answer is - yes it can be handled there.
>>>> But based on my experience it is very useful to be able to handle BIT
>>>> because it is built by tools by default.
>>>> Also with BIN format you are loosing record what this data bitstream
>>>> targets. Header in BIT gives you at least some ideas.
>>>
>>> People should stop using "cat" to program the FPGA and use a userspace
>>> tool instead. I've already released such tools under GPL, so anyone can
>>> pick up on it and extend it as required.
>>
>> Link?
> 
> https://github.com/topic-embedded-products/dyplo-utils/blob/master/dyploprogrammer.cpp
> 
> https://github.com/topic-embedded-products/libdyplo/blob/master/hardware.cpp#L261
> 
> 
> Will need some work to combine into a single tool though.
> 
>> This is fpga manager based driver where "cat" won't be used.
> 
> Haven't looked into it yet, but I guess at some point one will have to
> stream some data from userspace into the device, right?

Currently loading bitstream via firmware interface is used.

> 
>>> The header for the "bit" format is completely ignored (you can't even
>>> use it to determine if the bitstream is compatible with the current
>>> device) so there's no point in carrying it around.
>>
>> up2you what you want to do with it. If you work with different boards
>> with different FPGAs it is at least helpful to know if X.bit target this
>> or that board. Unfortunately I am not aware about any public document
>> which describe what there is written.
>>
>>> On the zynq, doing
>>> the "swap" in userspace was measurably faster than having the driver
>>> handle it, and that was even without using NEON instructions for byte
>>> swapping.
>>>
>>> I admit that being able to do "cat static.bit > /dev/xdevcfg" has had
>>> its uses. But it's not something that belongs in mainline Linux.
>>
>> It is about comfort but I have really not a problem that driver will
>> handle just BIN format.
>>
>>> Probably one of the key reasons that the "bit" format is still popular
>>> is that getting the Vivado tools to create a proper "bin" that will
>>> actually work on the Zynq is about as easy as nailing jelly to a tree.
>>> We've been using a simple Python script to do the bit->bin conversion
>>> for that reason.
>>
>> In vivado it is one tcl cmd. But truth is that I don't really get why
>> BIN is not generated by default.
> 
> If I recall correctly, Vivado strips the "bit" header but doesn't swap
> the bytes, so the resulting bin file won't work.


I have built bitstream from vivado 2014.4 and if you dump bit you will
see this.

All stuff in front of 0xaa995566 at 0xa0 is header.

00000000  00 09 0f f0 0f f0 0f f0  0f f0 00 00 01 61 00 32
|.............a.2|
00000010  64 65 73 69 67 6e 5f 31  5f 77 72 61 70 70 65 72
|design_1_wrapper|
00000020  3b 55 73 65 72 49 44 3d  30 58 46 46 46 46 46 46
|;UserID=0XFFFFFF|
00000030  46 46 3b 56 65 72 73 69  6f 6e 3d 32 30 31 34 2e
|FF;Version=2014.|
00000040  34 00 62 00 0c 37 7a 30  32 30 63 6c 67 34 38 34
|4.b..7z020clg484|
00000050  00 63 00 0b 32 30 31 35  2f 31 30 2f 31 33 00 64
|.c..2015/10/13.d|
00000060  00 09 31 30 3a 35 33 3a  33 38 00 65 00 3d ba fc
|..10:53:38.e.=..|
00000070  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
|................|
*
00000090  00 00 00 bb 11 22 00 44  ff ff ff ff ff ff ff ff
|.....".D........|
000000a0  aa 99 55 66 20 00 00 00  30 02 20 01 00 00 00 00  |..Uf ...0.
.....|


On the other hand bin format has also small header which can be skipped
for devcfg usage but doesn't need to be (I have tested it)

I do use this command for bitstream in bin format generation (it was in
edk 14.7).
promgen -p bin -data_width 32 -b -u 0x0 *.bit -w

00000000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
|................|
*
00000020  bb 00 00 00 44 00 22 11  ff ff ff ff ff ff ff ff
|....D.".........|
00000030  66 55 99 aa 00 00 00 20  01 20 02 30 00 00 00 00  |fU..... .
.0....|
00000040  01 00 02 30 00 00 00 00  01 80 00 30 00 00 00 00
|...0.......0....|
00000050  00 00 00 20 01 80 00 30  07 00 00 00 00 00 00 20  |...
...0....... |
00000060  00 00 00 20 01 60 02 30  00 00 00 00 01 20 01 30  |...
.`.0..... .0|
00000070  e5 3f 00 02 01 c0 01 30  00 00 00 00 01 80 01 30
|.?.....0.......0|
00000080  93 70 72 03 01 80 00 30  09 00 00 00 00 00 00 20
|.pr....0....... |
00000090  01 c0 00 30 01 04 00 00  01 a0 00 30 01 05 00 00
|...0.......0....|
000000a0  01 c0 00 30 00 00 00 00  01 00 03 30 00 00 00 00
|...0.......0....|
000000b0  00 00 00 20 00 00 00 20  00 00 00 20 00 00 00 20  |... ... ...
... |

Thanks,
Michal
