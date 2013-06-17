From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 17 Jun 2013 15:23:45 +0200
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <51BF0AD7.1070101@schinagl.nl>
References: <1371251781-17167-1-git-send-email-oliver+list@schinagl.nl>
 <1894396.Y9rMOhn2P3@amdc1227> <51BF0AD7.1070101@schinagl.nl>
Message-ID: <2650626.N0ZZQX0iR6@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 of June 2013 15:10:47 Oliver Schinagl wrote:
> On 17-06-13 14:51, Tomasz Figa wrote:
> > On Monday 17 of June 2013 12:36:47 Oliver Schinagl wrote:
> >> On 15-06-13 12:28, Tomasz Figa wrote:
> >>> Hi,
> >>> 
> >>> Some comments inline.
> >> 
> >> Thank you
> > 
> > You're welcome. :)
> > 
> >>> On Saturday 15 of June 2013 01:16:20 Oliver Schinagl wrote:
> >>>> From: Oliver Schinagl <oliver@schinagl.nl>
> >>>> 
> >>>> Allwinner has electric fuses (efuse) on their line of chips. This
> >>>> driver
> >>>> reads those fuses, seeds the kernel entropy and exports them as a sysfs
> >>>> node.
> 
> <snip>
> 
> >> I will change the comment, 'and 4 byte sized keys per SID' is probably
> >> better
> >> The array is 128 bits split into 32 bit words. Each 32 bit word consists
> >> of 8 bits (1 byte).
> >> So 4 * 4 = 16 bytes (SID_SIZE), is 128 bits.
> > 
> > What about:
> > 	/* There are 4 keys. */
> > 	#define SID_KEYS 4
> > 	/* Each key is 4 byte long (32-bit). */
> > 	#define SID_SIZE (SID_KEYS * 4)
> 
> I'll ommit the 'long (32-bit)' part but yeah that's probably enough.
> 
> <snip>
> 
> >>>> +
> >>>> +	if (offset >= SID_SIZE)
> >>>> +		goto exit;
> >>>> 
> >>> 		return 0; ...
> >> 
> >> I did say in the changelog I opted for goto over return. But since
> >> everybody keeps preferring returns (I personally like 'one single exit
> >> point much more' I have already changed it all over to many returns, who
> >> am I to argue :)
> > 
> > Well, single exit points makes sense (and is much nicer) when you have
> > something to do before exiting, take error paths as an example. But
> > jumping
> > just to return makes no sense, because when reading the code you must
> > scroll down to the label to check what actually happens.
> 
> But functions shouldn't be so large :p But that is the first reasonable
> reason I can live with :)
> 
> <snip>
> 
> >>>> +
> >>>> +	for (i = 0; i < SID_SIZE; i++)
> >>>> +		entropy[i] = sunxi_sid_read_byte(sid_reg_base, i);
> >>> 
> >>> You seem to read bytes into an array of ints. Your entropy data will
> >>> always have most significant 24-bits cleared. Is this behavior correct?
> >> 
> >> Yes, though I changed it so that entropy is an array of u8's, since
> >> that's what sunxi_sid_read_byte returns.
> >> 
> >>>> +	add_device_randomness(entropy, SID_SIZE);
> >>> 
> >>> Now I'm pretty sure that above is not the correct behavior. You are
> >>> adding
> >>> here first 16 bytes (=SID_SIZE) of entropy[], while it is an array of 16
> >>> ints (=4*SID_SIZE)...
> >> 
> >> Well technically, doesn't to compiler see that entropy is never larger
> >> then 8 bits and thus uses only 8 bits? uint8_atleast or something. But
> >> yeah, it's better to use the specified size to not waste 24 empty bits.
> > 
> > I mean, the loop fills the array with SID_SIZE ints, each with 3 zero
> > bytes and 1 byte of actual data, so you get:
> > 
> > S0 0x00 0x00 0x00 S1 0x00 0x00 0x00 ... S15 0x00 0x00 0x00
> 
> Ok, I get that
> 
> > but by calling add_device_randomness() with SID_SIZE as size argument, you
> > add only 16 first bytes of data from the array:
> > 
> > S0 0x00 0x00 0x00 S1 0x00 0x00 0x00 ... S3 0x00 0x00 0x00
> 
> That bit I'm not quite sure I understand:
> 
> We have an array of ints, { 0x00000000, 0x00000000, 0x00000000 .... }
> We read 1 byte and copy it to the array (x16) (say sid = 0xdeadbeef...)
> { 0x000000de, 0x000000ad, 0x000000be, ... }
> 
> Now we pass this array to add_randomness(array, 16). So add_randomness
> sees 16 ints in an array. So while there will be a lot of extra zero's,
> there still be 16 elements copied/processed, no?

The second argument of add_randomness is number of bytes, not number of 
elements in array, as far as I can tell.

Best regards,
Tomasz

> Otherwise, how does add_randomness() know it's dealing with bytes or
> ints? it just see's the pointer to an int array that is 16 long? Or what
> am I overlooking?
> 
> I did already change the array to be u8 big so it is only to help me
> understand.
> 
> > (little endianness assumed)
> > 
> > Best regards,
> > Tomasz
> > 
> > (for rest of comments I think it's enough said in Russell's and Maxime's
> > replies)
> 
> Yes it has :) thanks to all of you
> 
> Oliver
