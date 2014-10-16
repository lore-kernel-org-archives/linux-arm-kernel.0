From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Oct 2014 23:19:17 +0100
Subject: imx6: ipu: wrong pixel clock
In-Reply-To: <54401266.7090802@myspectrum.nl>
References: <54401266.7090802@myspectrum.nl>
Message-ID: <20141016221917.GP27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 08:45:58PM +0200, Jeroen Hofstee wrote:
> 9Mhz -> actual 21 Mhz when measured
> [    1.707543] imx-ipuv3 2400000.ipu: disp 0: panel size = 480 x 272
> [    1.707568] imx-ipuv3 2400000.ipu: Clocks: IPU 264000000Hz DI 24000000Hz
> Needed 9000000Hz
> [    1.707672] imx-ipuv3 2400000.ipu:   IPU clock can give 9103448 with
> divider 29, error 1.1%
> [    1.707889] imx-ipuv3 2400000.ipu: Want 9000000Hz IPU 264000000Hz DI
> 9000000Hz using DI, 9000000Hz
> [    1.708026] imx-ipuv3 2400000.ipu: dmfc: trying to allocate 7Mpixel/s for
> IPU channel 23
> [    1.708038] imx-ipuv3 2400000.ipu: dmfc: freeing 0 slots starting from
> segment 0
> [    1.708131] imx-ipuv3 2400000.ipu: dmfc: using 2 slots starting from
> segment 0 for IPU channel 23

I wonder if this is caused by the kernel's idea of the clock tree not being
the same as what the clock tree actually is.

The IPU DI clock definitely does work as the code desires as it works with
HDMI and definitely does produce the right clock rate.

The clue I think is that you can't end up with a 21MHz clock from a DI
clock of 24MHz with an integer divider.  So the clock rate which is
believed to be from the DI isn't correct.  I suspect a CCF/iMX problem.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
