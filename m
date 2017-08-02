From: slash.tmp@free.fr (Mason)
Date: Wed, 2 Aug 2017 16:41:07 +0200
Subject: [RFC PATCH v2 0/2] nb8800 suspend/resume support
In-Reply-To: <33d1ab47-6098-5e3f-8a3c-f72626d07113@free.fr>
References: <33d1ab47-6098-5e3f-8a3c-f72626d07113@free.fr>
Message-ID: <aa8885b8-e6bb-3624-2bf9-0bb40505ac54@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2017 18:32, Mason wrote:

> I need suspend/resume support in the nb8800 driver.
> On tango platforms, suspend loses all context (MMIO registers).
> To make the task easy, we just close the device on suspend,
> and open it again on resume. This requires properly resetting
> the HW on resume.
> 
> Patch 1 moves all the HW init to nb8800_init()
> Patch 2 adds suspend/resume support

I have now confirmed that the "flow control" issue I reported
in another thread has nothing to do with flow control per se.

The problem is that nb8800_pause_config() calls nb8800_dma_stop()
and when it does, RX is borked.

On a GigE switch:
[   21.444268] ENTER nb8800_pause_config
[   21.448604] rxcr=06100a8f pause_rx=1 pause_tx=0 pause=1 asym_pause=1
[   21.455020] nb8800 26000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx

In this case, pause_tx and RCR_FL match, so we skip the
silly dance.

On a FastE switch:
[   11.611613] ENTER nb8800_pause_config
[   11.615942] rxcr=06100a8f pause_rx=1 pause_tx=1 pause=1 asym_pause=0
[   11.825535] nb8800 26000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx

In this case pause_tx and RCR_FL don't match, so we hit
nb8800_dma_stop() and the HW block becomes deaf.

In conclusion, two issues I've been discussing:
A) RX wedged after ndo_close
B) flow control breaks on FastE switches
are in fact two symptoms of the same root issue.

Regards.
