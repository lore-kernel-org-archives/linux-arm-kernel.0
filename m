From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Mon, 12 Oct 2015 14:22:36 +0200
Subject: [PATCH 3/3] fpga manager: Adding FPGA Manager support for Xilinx
 Zynq 7000
In-Reply-To: <561B9687.1070103@xilinx.com>
References: <1444344307-22509-1-git-send-email-moritz.fischer@ettus.com>
 <1444344307-22509-4-git-send-email-moritz.fischer@ettus.com>
 <20151009163336.GM10631@jcartwri.amer.corp.natinst.com>
 <CAAtXAHea7GZDLez5kYas2PFQ-=KmS_on8WxFDCuvVb4Nh05a_w@mail.gmail.com>
 <561B9687.1070103@xilinx.com>
Message-ID: <561BA60C.6010106@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?On 12-10-15 13:16, Michal Simek wrote:
>
>>>> +static int zynq_fpga_ops_write(struct fpga_manager *mgr,
>>>> +                            const char *buf, size_t count)
>>>> +{
>>>> +     struct zynq_fpga_priv *priv;
>>>> +     int err;
>>>> +     char *kbuf;
>>>> +     size_t i, in_count;
>>>> +     dma_addr_t dma_addr;
>>>> +     u32 transfer_length = 0;
>>>> +     bool endian_swap = false;
>>>> +
>>>> +     in_count = count;
>>>> +     priv = mgr->priv;
>>>> +
>>>> +     kbuf = dma_alloc_coherent(priv->dev, count, &dma_addr, GFP_KERNEL);
>>>> +     if (!kbuf)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     memcpy(kbuf, buf, count);
>>>> +
>>>> +     /* look for the sync word */
>>>> +     for (i = 0; i < count - 4; i++) {
>>>> +             if (memcmp(kbuf + i, "\x66\x55\x99\xAA", 4) == 0) {
>>>> +                     dev_dbg(priv->dev, "Found normal sync word\n");
>>>> +                     endian_swap = false;
>>>> +                     break;
>>>> +             }
>
> This is bin format
>
>>>> +             if (memcmp(kbuf + i, "\xAA\x99\x55\x66", 4) == 0) {
>>>> +                     dev_dbg(priv->dev, "Found swapped sync word\n");
>>>> +                     endian_swap = true;
>>>> +                     break;
>>>> +             }
>
> This is bit format from header
>
>>>> +     }
>>>
>>> How much control do we have over mandating the format of firmware at
>>> this point?  It'd be swell if we could just mandate a specific
>>> endianness, and leave this munging to usermode.
>>
>> That's a good question. Personally I do only care about one of both,
>> but that's just because I get to decide for my targets...
>> Opinions from the Xilinx guys?
>
> Don't know full history about this but in past bitstream in BIT format
> was used. Which is header (partially decoding in u-boot for example)
> with data.
> On zynq native format is BIN which is format without header and data is
> swapped.
> This code just detects which format is used. If BIT, header is skipped
> and data is swapped to BIN format.
>
> Back to origin question if this is something what can be handled from
> user space. And answer is - yes it can be handled there.
> But based on my experience it is very useful to be able to handle BIT
> because it is built by tools by default.
> Also with BIN format you are loosing record what this data bitstream
> targets. Header in BIT gives you at least some ideas.

People should stop using "cat" to program the FPGA and use a userspace tool 
instead. I've already released such tools under GPL, so anyone can pick up on 
it and extend it as required.

The header for the "bit" format is completely ignored (you can't even use it 
to determine if the bitstream is compatible with the current device) so 
there's no point in carrying it around. On the zynq, doing the "swap" in 
userspace was measurably faster than having the driver handle it, and that was 
even without using NEON instructions for byte swapping.

I admit that being able to do "cat static.bit > /dev/xdevcfg" has had its 
uses. But it's not something that belongs in mainline Linux.

Probably one of the key reasons that the "bit" format is still popular is that 
getting the Vivado tools to create a proper "bin" that will actually work on 
the Zynq is about as easy as nailing jelly to a tree. We've been using a 
simple Python script to do the bit->bin conversion for that reason.

Using the "bin" format in the driver keeps it simple and singular. Userspace 
tools can add whatever wrappers and headers they feel appropriate to it, these 
checks don't belong in the driver since they will be application specific. For 
example, some users would want to verify that a partial bitstream actually 
matches the static part that's currently in the FPGA.

Mike.


Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans at topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
