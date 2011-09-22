From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 22 Sep 2011 21:29:09 +0100
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20110922184614.25419.84606.stgit@ponder>
References: <20110922184614.25419.84606.stgit@ponder>
Message-ID: <20110922212909.49966cf4@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Definitely what is needed for some of the x86 SoC stuff and would let us
rip out some of the special case magic for the SCU discovery.

First thing that strikes me is driver_bound kicks the processing queue
again. That seems odd - surely this isn't needed because any driver that
does initialise this time and may allow something else to get going will
queue the kick itself. Thus this seems to just add overhead.

It all looks a bit O(N?) if we don't expect the drivers that might
trigger something else binding to just say 'hey I'm one of the
troublemakers'
