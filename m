From: matt@genesi-usa.com (Matt Sealey)
Date: Thu, 2 Jun 2011 18:59:49 -0500
Subject: i.MX consolidation patches
In-Reply-To: <20110602154659.697EFD09481@gemini.denx.de>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<20110530075745.GA31492@S2100-06.ap.freescale.net>
	<20110601123522.GE23771@pengutronix.de>
	<20110601134749.GI3660@n2100.arm.linux.org.uk>
	<20110601141847.GG23771@pengutronix.de>
	<20110601210855.663A3CEFB4E@gemini.denx.de>
	<BANLkTi=HqEBRzyU4_HXnNHTeOPL9vPW8PA@mail.gmail.com>
	<20110602154659.697EFD09481@gemini.denx.de>
Message-ID: <BANLkTimk1fVi7YdwmCFJ1-M82NSHe4SzYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 2, 2011 at 10:46 AM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Matt,
>
>> * Assuming all ARM kernels are PIC (guaranteed, right?)
>> * Assuming all ARM kernels start at entry point 0 (true for Image and zImage)
>
> You mean offset 0 to the start of the image here.

Yep. I missed a couple words between point and 0 :)

>> * Assuming there is a globally invalid magic value you can set in the
>> uImage header as load address (not sure)
>
> I dislike this.

Me too but how else would you do it? A flag in the uImage header that says
disregard the load address would work. Or a U-Boot that basically disregarded
the load address *anyway*.

I understand Sascha pointed out 0x0 is the standard load address on PPC
but we're talking about an ARM thing here. U-Boot knows both what processor
it is built for and it knows from the uImage header which architecture
the kernel
image is for. It only needs to be true that 0x0 is totally invalid,
stupid value to
use as a load address on ARM, and it would comply with the expectations that
if (address) then it can carry on as before, else do the "new" behavior of
deriving the address of the Linux entry point..

>> Set that magic value, U-Boot magically derives the correct entry point
>> as the first address of the payload,
>> and jumps to it?
>
> That means you would not want to encode a load address in the image,
> and always run from the current location, no matter where it is?

Exactly. Isn't this the beauty of position independent code, that you don't need
to hardcode a load address?

In the case of most Linux images the first thing they do is decompress
themselves
anyway.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
