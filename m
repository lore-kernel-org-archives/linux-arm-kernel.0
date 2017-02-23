From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 23 Feb 2017 16:05:32 +0800
Subject: [PATCH 00/11] drm/sun4i: Various fixes and cleanups part 2
Message-ID: <20170223080543.6659-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This is the second bunch of fixes for the sun4i drm driver. This is part
of the cleanup I am doing towards making the driver support multiple
display pipelines.

This part mainly aims to get detection of crtcs working with of_graph,
and moving data structure pointers around for a more layered and
connected approach of associating the various components:

	----------              ---------
	|----------             |---------
  SW:	||        |  included   ||       |
	|| layers | ----------> || crtcs |
	-|        |     in      -|       |
	 ----------              ---------

	      |   \_______________   |
	      |                   \  |
	      v	     maps to      v  v

	------------            ---------
	|------------           |---------
  HW:	||          |   feeds   ||       |
	|| backends | --------> || tcons |
	-|          |           -|       |
	 ------------            ---------

This will make it easier to support multiple display pipelines, as
we only have to deal with indexes at bind time.


Patch 1 makes the table of RGB-to-YUV conversion coefficients constant.

Patch 2 sets the crtc's output port so drm_of_find_possible_crtcs can
work.

Patch 3 adds an empty end of list element to the list of layers returned
from sun4i_layers_init.

Patch 4 moves the list of layers from the main sun4i_drv structure into
the crtc.

Patch 5 initializes the crtc within the tcon's bind function. The crtc
has to be initialized before any encoders downstream of the tcon, so
drm_of_find_possible_crtcs() used within encoder bind functions work.
Previously crtcs were initialized after all hardware components were
bound.

Patch 6 drops the pointer to the primary layer/plane from sun4i_drv.
This pointer was only used for initializing the crtc later on.

Patch 7 drops the hardcoded .possible_crtcs values for the layers.
Instead we iterate through the list of layers and set the value
for overlay layers with the value derived from the crtc that was
just initialized.

Patch 8 makes the tv encoder driver use drm_of_find_possible_crtcs
instead of a hardcoded value.

Patch 9 adds a argument to pass the tcon pointer when initializing
the RGB encoder.

Patch 10 adds a pointer to the underlying backend to sun4i_layer.

Patch 11 adds pointers to the underlying backend and tcon to
sun4i_crtc.


Please have a look. Notably, I do not have hardware to test patch 8,
though I do not expect any problems.

Still to come is the actual work of supporting many display pipelines.

Regards
ChenYu

Chen-Yu Tsai (11):
  drm/sun4i: Make sunxi_rgb2yuv_coef constant
  drm/sun4i: Set drm_crtc.port to the underlying TCON's output port node
  drm/sun4i: Add end of list element for sun4i_layers_init's returned
    list
  drm/sun4i: Move layers from sun4i_drv to sun4i_crtc
  drm/sun4i: Initialize crtc from tcon bind function
  drm/sun4i: Drop primary layer pointer from sun4i_drv
  drm/sun4i: Drop hardcoded .possible_crtcs values from layers
  drm/sun4i: tv: Switch to drm_of_find_possible_crtcs
  drm/sun4i: rgb: Pass tcon pointer when initializing RGB encoder
  drm/sun4i: Add backend pointer to sun4i_layer
  drm/sun4i: Add backend and tcon pointers to sun4i_crtc

 drivers/gpu/drm/sun4i/Makefile        |  4 +--
 drivers/gpu/drm/sun4i/sun4i_backend.c |  2 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c    | 57 +++++++++++++++++++++++++++++------
 drivers/gpu/drm/sun4i/sun4i_crtc.h    |  4 ++-
 drivers/gpu/drm/sun4i/sun4i_drv.c     | 17 -----------
 drivers/gpu/drm/sun4i/sun4i_drv.h     |  4 ---
 drivers/gpu/drm/sun4i/sun4i_layer.c   | 16 ++++------
 drivers/gpu/drm/sun4i/sun4i_layer.h   |  1 +
 drivers/gpu/drm/sun4i/sun4i_rgb.c     | 30 +++++++-----------
 drivers/gpu/drm/sun4i/sun4i_rgb.h     |  2 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c    | 12 ++++++--
 drivers/gpu/drm/sun4i/sun4i_tcon.h    |  3 ++
 drivers/gpu/drm/sun4i/sun4i_tv.c      |  8 ++++-
 13 files changed, 91 insertions(+), 69 deletions(-)

-- 
2.11.0
