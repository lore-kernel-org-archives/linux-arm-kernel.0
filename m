From: sourav.poddar@ti.com (Sourav Poddar)
Date: Fri, 23 Aug 2013 15:27:43 +0530
Subject: [PATCH V1 3/5] mtd: m25p80: add the quad-read support
In-Reply-To: <52172A81.5090501@freescale.com>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>	<1376885403-12156-4-git-send-email-b32955@freescale.com>
 <CAHSAbzN166J=DFi+1koPUpnFpJVHwtbC1AP21ywhAAissQxPxg@mail.gmail.com>
 <52172A81.5090501@freescale.com>
Message-ID: <52173217.70505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 August 2013 02:55 PM, Huang Shijie wrote:
> ? 2013?08?23? 17:05, yuhang wang ??:
>>> +       u16 sr_cr;
>>> >  +       int ret;
>>> >
>>> >    #ifdef CONFIG_MTD_OF_PARTS
>>> >           if (!of_device_is_available(np))
>>> >  @@ -1014,6 +1050,21 @@ static int m25p_probe(struct spi_device *spi)
>>> >           else
>>> >                   flash->read_opcode = OPCODE_NORM_READ;
>>> >
>>> >  +       /* Try to enable the Quad Read */
>>> >  +       if (np&&  of_property_read_bool(np, "m25p,quad-read")) {
>>> >  +               /* The configuration register is set by the 
>>> second byte. */
>>> >  +               sr_cr = CR_QUAD<<  8;
>>> >  +
>>> >  +               /* Write the QUAD bit to the Configuration 
>>> Register. */
>>> >  +               write_enable(flash);
>>> >  +               if (write_sr_cr(flash, sr_cr) == 0) {
>>> >  +                       /* read back and check it */
>>> >  +                       ret = read_cr(flash);
>>> >  +                       if (ret>  0&&  (ret&  CR_QUAD))
>>> >  +                               flash->read_opcode = OPCODE_QIOR;
>>> >  +               }
>>> >  +       }
>>> >  +
>> Well, M25p80.c support lots of flash devices, so driver should be as
>> general as possible. Firstly not all the devices m25p80 supports set
>> quad mode as your sequence, perhaps write_sr_cr can not match all the
> It does not matter the NOR flash supports the write_sr_cr() or not,
> If the NOR flash does not support the write_sr_cr(), it may fails, and 
> you will not set the OPCODE_QIOR for the
> m25p80_read.
>
>> m25p80 flash. Secondly, why you only support QIOR(high performance)
>> not QOR or DOR. Maybe QIOR seems too special, so what if user want to
>> use QOR if he set quad mode in DTS.
>>
> Frankly speaking, i am reluctant to support the QIOR, it is a little 
> slow. :)
>
You should add QOR opcodes also in your patch, so we have the complete set.
> So the the QIOR is lowest speed for QUADSPI controller, and i do not 
> want to support the DOR.
>
> In my new version, i add the support for DDR QIOR read which is the 
> double rate of the QIOR.
>
> The user should knows if the NOR flash supports the quad-read or not, 
> and set the proper DT.
>
>> Another point, if command changed to OPCODE_QIOR, there should also
>> should be some correct in m25p_read. such as the number of dummy data.
> I only need to change the read opcode.
>> QIOR can support read without read command if set the certain bit in
>> transfer, these aspects did not reflect in your patch.
>>
> For the Quadspi, it will handle the dummy by the LUT sequence, such as 
> DDR QUAD read, the LUT sequence will
> set proper dummy (6 cycles for S25FL128S). I do not need the m25p_read 
> to set the dummy.
>
>
> thanks
> Huang Shijie
>
>
>
>
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
