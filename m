From: subaparts@yandex.ru (Alexander)
Date: Sun, 16 Jan 2011 14:21:02 +0300
Subject: [PATCH 1/3] ASoC: EP93xx I2S and PCM fixes
In-Reply-To: <20101210150758.GE3200@rakim.wolfsonmicro.main>
References: <1291809693.31916.2.camel@r60e>
	<20101208124637.GD16418@rakim.wolfsonmicro.main>
	<1291855051.31916.85.camel@r60e>
	<20101209105443.GA4469@rakim.wolfsonmicro.main>
	<1291897061.31916.149.camel@r60e>
	<20101209123457.GD4469@rakim.wolfsonmicro.main>
	<1291929258.16839.17.camel@r60e>
	<20101210150758.GE3200@rakim.wolfsonmicro.main>
Message-ID: <1295176862.15631.168.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark,

Well, now I have time to deal with this again, sorry for long pause.
I've found, that author of code, on which modern ep93xx-i2s.c and
ep93xx-pcm.c are based, had faced this problem also in 2007:
http://blog.gmane.org/gmane.linux.ports.arm.cirrus/month=20070101/page=3

Now SoC code uses his developments, but not overcomes the hardware
issues. Some details from EP93xx users guide:

Both I2S transmitter and receiver have similar 16x32bit FIFO, where they
store 8 samples for both left and right channels. The FIFO is always
32bit wide and should be properly aligned if you use samples of other
width. Transmitter and receiver have configuration registers for
selection of I2S word length (16, 24, 32). They are I2STXWrdLen and
I2SRXWrdLen.

Yes, EP93xx DMA can do byte, word and quad-word transfers. The width for
transfers to and from peripherals is selected by particular module
configuration. Lucky AC97 module has such configuration: AC97RXCRx
registers, bit CM (Compact mode enable) switches between 16 and 32 bit
samples. AC97TXCRx registers have the same bits for transmitters.
ep93xx-ac97.c enables this compact mode and so has all the rights to use
S16_LE format.
No one has found such a configuration in I2S module until now in any
Cirrus manuals. I2S module always feeds it's 32bit wide FIFO with 32bit
samples consecutively for left and right channels. You cannot use 32-bit
DMA transfers to transfer two 16-bit samples. 

So we can use two formats for AC97, but should remove all but S32_LE for
I2S.

Should I resend my patches now?

Best regards,
	Alexander A. Sverdlin.

On Fri, 2010-12-10 at 15:07 +0000, Mark Brown wrote:
> On Fri, Dec 10, 2010 at 12:14:18AM +0300, Alexander wrote:
> 
> > BTW, it's how original Cirrus's sound driver had done it's work. Cirrus
> > programmers had not found a way to overcome this. The datasheets for
> > EP93xx series cover everything only briefly... The dumbness of EP93xx's
> > DMA is also the reason why we do not have DMA in serial ports and SSP...
> 
> > The function I'm talking about is snd_ep93xx_dma2usr_ratio(), as told in
> > comments "For audio playback, we convert samples of arbitrary format to
> > be 32 bit for our hardware".
> 
> This doesn't really answer any of my technical questions about what's
> going on here.
> 
> Please resubmit with a changelog explaining what the limitations are on
> both sides (DMA seems clear but the I2S also needs to be covered) and
> makes it clear why the functionality is being reduced like this.  This
> will ensure that users understand why the change has been made - right
> now it looks like a serious functionality regression is being
> introduced so we really should make it clear why this is being done.
> 
