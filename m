From: jassisinghbrar@gmail.com (jassi brar)
Date: Thu, 17 Sep 2009 16:57:22 +0900
Subject: S3C64XX DMA Issues
Message-ID: <1b68c6790909170057n391602a4l6cebb10cac357c7b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
  I wanted to list out the issues in the s3c64xx dma driver. Since
currently only I2S makes use of the DMA driver, the symptoms can be
seen while playing(rather trying to) audio.

1) The current implementation doesn't work if the client wants to
manage queue length of 2.
 The problem arises because by the time the client enqueues a new
buffer, DMAC has already read the LLI
of the last(at the time of IRQ) buffer which, obviously, comes out to
be zero. As a result, the state
machine stops after just two buffer xfers.

As a consequence, S3C standard minimum periods(2) set for I2S doesn't
work. Minimum periods
 has to be set to 3 or more. The work around maybe simple(set
periods_min=3) but the DMA state-machine has a problem nevertheless.

2) As already explained in my emails, the dma driver hogs memory with
simple traditional usage.
Stereo, 16bpc @44.1KHz playback fails within half an hour, complaining
"no memory for lli".
