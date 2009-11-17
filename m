From: ospite@studenti.unina.it (Antonio Ospite)
Date: Tue, 17 Nov 2009 23:04:20 +0100
Subject: [PATCH 0/3] pxa_camera: remove init() callback
Message-ID: <1258495463-26029-1-git-send-email-ospite@studenti.unina.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series removes the init() callback from pxa_camera_platform_data, and
fixes its users to do initialization statically at machine init time.

Guennadi requested this change because there seems to be no use cases for
dynamic initialization. I also believe that the current semantics for this
init() callback is ambiguous anyways, it is invoked in pxa_camera_activate(),
hence at device node open, but its users use it like a generic initialization
to be done at module init time (configure MFP, request GPIOs for *sensor*
control).

So removing it is definitely good.
As a side note, If we were really exposing some dynamic and generic
initialization, this could be done in soc-camera itself, not in pxa_camera
anyways.

Thanks,
   Antonio

Antonio Ospite (3):
  em-x270: don't use pxa_camera init() callback
  pcm990-baseboard: don't use pxa_camera init() callback
  pxa_camera: remove init() callback

 arch/arm/mach-pxa/em-x270.c             |    9 +++++----
 arch/arm/mach-pxa/include/mach/camera.h |    2 --
 arch/arm/mach-pxa/pcm990-baseboard.c    |    8 +-------
 drivers/media/video/pxa_camera.c        |   10 ----------
 4 files changed, 6 insertions(+), 23 deletions(-)

--
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?
