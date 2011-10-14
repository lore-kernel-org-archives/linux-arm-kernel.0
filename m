From: stefan.xk.nilsson@stericsson.com (Stefan Nilsson XK)
Date: Fri, 14 Oct 2011 09:38:05 +0200
Subject: [PATCH 1/4] mmc: mmci: Bugfix in pio read for small packets
In-Reply-To: <20111007191128.GA25689@n2100.arm.linux.org.uk>
References: <1317109568-17905-1-git-send-email-ulf.hansson@stericsson.com>
	<20111001160937.GF11710@n2100.arm.linux.org.uk>
	<4E895F6A.9070203@stericsson.com> <4E8F00E4.5010702@stericsson.com>
	<20111007191128.GA25689@n2100.arm.linux.org.uk>
Message-ID: <4E97E6DD.4030605@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2011 09:11 PM, Russell King - ARM Linux wrote:
> But first, you need to fix your code so you're only reading 32-bit
> quantities from the FIFO register.

Hi Russel, what to you think of doing it this way instead:

		/*
		 * SDIO especially may want to send something that is
		 * not divisible by 4 (as opposed to card sectors
		 * etc), and the FIFO only accept full 32-bit reads.
		 */
		if (count < 4) {
			unsigned char buf[4];
			readsl(base + MMCIFIFO, buf, 1);
			memcpy(ptr, buf, count);
		}
		else
			readsl(base + MMCIFIFO, ptr, count >> 2);

This makes sure we only access the FIFO in a 32 bit way, and the only 
overhead for the "standard" case (count >= 4) is the "if" clause. I have 
verified this to work with our WLAN driver.

Best Regards

Stefan Nilsson
