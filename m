From: david@lechnology.com (David Lechner)
Date: Mon, 7 Aug 2017 11:03:36 -0500
Subject: [PATCH v3 4/6] drm/tinydrm: add support for LEGO MINDSTORMS EV3
 LCD
In-Reply-To: <d814508b-1225-b385-6a90-091487bee2b5@tronnes.org>
References: <1501799630-1650-1-git-send-email-david@lechnology.com>
 <1501799630-1650-5-git-send-email-david@lechnology.com>
 <d814508b-1225-b385-6a90-091487bee2b5@tronnes.org>
Message-ID: <2abbab73-0314-aaca-29b0-6366452d921b@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2017 01:19 PM, Noralf Tr?nnes wrote:
> 
> Den 04.08.2017 00.33, skrev David Lechner:
>> +
>> +    buf = kmalloc(len, GFP_KERNEL);
>> +    if (!buf)
>> +        return;
>> +
>> +    tinydrm_xrgb8888_to_gray8(buf, vaddr, fb, clip);
>> +    src = buf;
>> +
>> +    for (y = clip->y1; y < clip->y2; y++) {
>> +        for (x = clip->x1; x < clip->x2; x += 3) {
>> +            val = *src++ & 0xc0;
>> +            if (val & 0xc0)
>> +                val |= 0x20;
>> +            val |= (*src++ & 0xc0) >> 3;
>> +            if (val & 0x18)
>> +                val |= 0x04;
>> +            val |= *src++ >> 6;
>> +            *dst++ = ~val;
> 
> I don't understand how this pixel packing matches the one described in
> the datasheet. Why do you flip the bits at the end?
> 

I a trying to be too clever. :-)

Here is the comment I will add to the next revision:

/*
  * The ST7586 controller has an unusual pixel format where 2bpp 
grayscale is
  * packed 3 pixels per byte with the first two pixels using 3 bits and 
the 3rd
  * pixel using only 2 bits.
  *
  * |  D7  |  D6  |  D5  ||  D1  |  D0  || 2bpp |
  * | (D4) | (D3) | (D2) ||      |      || GRAY |
  * +------+------+------++------+------++------+
  * |  1   |  1   |  1   ||  1   |  1   || 0  0 | black
  * |  1   |  0   |  0   ||  1   |  0   || 0  1 | dark gray
  * |  0   |  1   |  0   ||  0   |  1   || 1  0 | light gray
  * |  0   |  0   |  0   ||  0   |  0   || 1  1 | white
  */


As you can see, in the controller DRAM 1's are black and 0's are white, 
but in the kernel, it is the opposite. Also, if you look at the truth 
table, you can see that the extra 3rd bit has the pattern if D7 == 0 or 
D6 == 0 then D5 is zero.

I suppose it could be better to do this with a lookup table:

static const u8 st7586_lookup[] = { 0x7, 0x4, 0x2, 0x0 };

...

	for (y = clip->y1; y < clip->y2; y++) {
		for (x = clip->x1; x < clip->x2; x += 3) {
			val = st7586_lookup[*src++ >> 6] << 5;
			val |= st7586_lookup[*src++ >> 6] << 2;
			val |= st7586_lookup[*src++ >> 6] >> 1;
			*dst++ = val;
		}
	}
