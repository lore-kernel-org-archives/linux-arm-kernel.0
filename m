From: oliver+list@schinagl.nl (Oliver Schinagl)
Date: Fri, 24 May 2013 23:50:38 +0200
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <5197B82F.8010809@schinagl.nl>
References: <1368797744-13737-1-git-send-email-oliver+list@schinagl.nl>
 <1368797744-13737-2-git-send-email-oliver+list@schinagl.nl>
 <51969EA9.1060602@free-electrons.com> <5197B82F.8010809@schinagl.nl>
Message-ID: <519FE0AE.2010102@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/13 19:19, Oliver Schinagl wrote:
<snip>
>>> +
>>> +
>>> +/* We read the entire key, using a look up table. Returned is only the
>>> + * requested byte. This is of course slower then it could be and uses 4 times
>>> + * more reads as needed but keeps code a little simpler.
>>> + */
>>> +u8 sunxi_sid_read_byte(const int key)
>>> +{
>>> +	u32 sid_key;
>>> +	u8 ret;
>>> +
>>> +	ret = 0;
>>> +	if (likely((key <= SUNXI_SID_SIZE))) {
>>> +		sid_key = ioread32(p->sid_base + keys_lut[key >> 2]);
>>> +		switch (key % 4) {
>>> +		case 0:
>>> +			ret = (sid_key >> 24) & 0xff;
>>> +			break;
>>> +		case 1:
>>> +			ret = (sid_key >> 16) & 0xff;
>>> +			break;
>>> +		case 2:
>>> +			ret = (sid_key >> 8) & 0xff;
>>> +			break;
>>> +		case 3:
>>> +			ret = sid_key & 0xff;
>>> +			break;
>>> +		}
>>> +	}
>>
>> Come on, you can do better. This lookup table is useless.
> I didn't want to depend on the fixed layout of memory, but consider it
> removed.
But i'm not smart enough :p

We can either use the look up table (which does have benefits as its 
potentially more future proof), or do some ((key >> 2) << 2) to 'drop' 
the LSB's that we want to ignore (unless there's some smarter way).

Personally, I think the LUT is a little cleaner and more readable, but I 
guess if you look@poor efficiency, the lut costs some memory, the 
left/right shift cost an additional >> 2 ... what you prefer.
>>
>> Also, why the first key is the one with the MSBs?
>> I'd expect that the key 0 is the one holding the LSBs.
> Strangely enough, they have swapped the MSB and LSB bytes. I double
> checked it with u-boot and yep, swapped. Though in the end, if we write
> stuff there and we read stuff from there, order doesn't matter? So what
> do we prefer. Have it so that it makes sense and ignore how u-boot reads
> it, or correct it and be consistent?
>
You had me confused and I was looking at this for a little while. 
Bit-ordering does not change, Byte endianness is a different story of 
course. As it is now, I decided to use Big endianess. So now a 32bit key 
looks like:
0x162367c7 and if we read one byte at a time, we get 0x16, 0x23, 0x67 
and 0xc7. I made a comment that data is read as Big endian. If it is 
important, for eeprom data, to be stored little endian, I'll obviously 
change it per request.
