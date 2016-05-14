From: khilman@baylibre.com (Kevin Hilman)
Date: Sat, 14 May 2016 17:11:20 +0200
Subject: [RFC PATCH 0/3] Amlogic: GXBB: Add reset controller
In-Reply-To: <1463148012-25988-1-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Fri, 13 May 2016 16:00:09 +0200")
References: <1463148012-25988-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <m2eg941xpj.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Neil Armstrong <narmstrong@baylibre.com> writes:

> Patchset to add and enable the reset controller driver on GXBB platforms.

Looking closer at the vendor BSP reset driver, I realized that that
kernel doesn't seem to be using this reset IP at all.  Their reset
driver is actually just using clock gating in the HHI_GCLK_MPEGx
registers.

I'm not sure I understand why they made that choice (I've asked
off-list), but we'll need to keep in mind that any usage of the reset
driver in the vendor DTs corresponds do clock gating, and not this reset
IP.

In any case, other than the minor comments, this looks like a good
driver for the reset IP in the S905/GXBB.

Also, I gave this driver a quick test with the network driver support I
recently posted.  When the network driver is loaded, it deasserts the
reset and when unloaded, it asserts the reset.  Interestingly, the
assert cases a full system lockup. :(

I've asked some Amlogic folks off-list about this issue too, and hope to
get some more clarifcation (and ideally docs) about this reset IP soon.

Kevin
