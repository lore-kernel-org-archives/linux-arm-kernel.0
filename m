From: prylowski@metasoft.pl (Rafal Prylowski)
Date: Thu, 22 Mar 2012 11:00:37 +0100
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <4F6A78ED.3050403@gmail.com>
References: <4F683B36.8090101@metasoft.pl> <4F6A78ED.3050403@gmail.com>
Message-ID: <4F6AF845.9070209@metasoft.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-03-22 01:57, Ryan Mallon wrote:
> I haven't looked through the patch yet, since I'm waiting on more
> information from Mika and Hartley's testing.
> 
> However, the commit log doesn't tell me why we want this change. Is it a
> performance improvement? If so, do you have some numbers that we can
> paste into the commit log?

In principle, using double buffering should be faster than using only
one buffer and disabling/enabling channel each time. But my measurements
doesn't show any significant change.

The real reason for this change is that current code is not 100% reliable
in IDE-DMA (I'm planning to submit ep93xx ide driver to linux-ide soon).
Although using only one buffer and DONE interrupt is simple, surprisingly
we can get interrupt when M2M DMA is in DMA_BUF_ON and DMA_STALL state.
If we disable the channel at this moment, we end with ata timeout.
