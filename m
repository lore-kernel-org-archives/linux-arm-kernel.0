From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 27 Aug 2013 21:48:08 -0300
Subject: imx-ldb: "mx-ldb ldb.10: adding encoder failed with -16"
In-Reply-To: <CAOMZO5CjgfRLfcgRjO2eAx4ZQkZNHVe7tLqeCacJndTJiDGg_w@mail.gmail.com>
References: <CAOMZO5CjgfRLfcgRjO2eAx4ZQkZNHVe7tLqeCacJndTJiDGg_w@mail.gmail.com>
Message-ID: <CAOMZO5DzVNy-Qe4SyTPvuGdBO-ev=K+gyWSGosTmRpGzfOjBEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 9:35 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi,
>
> Running next-20130827 I get the following probe failure on mx6:
>
> [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
> [drm] No driver support for vblank timestamp query.
> [drm] Initialized imx-drm 1.0.0 20120507 on minor 0
> imx-ldb ldb.10: adding encoder failed with -16

If I revert this commit:

commit b5dc0d108cd3c0b50ddcb6f6c54be1bea4c39e01
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu Aug 8 15:41:13 2013 +0200

    drm/imx: kill firstopen callback

    This thing seems to do some kind of delayed setup. Really, real kms
    drivers shouldn't do that at all. Either stuff needs to be dynamically
    hotplugged or the driver setup sequence needs to be fixed.

    This patch here just moves the setup at the very end of the driver
    load callback, with the locking adjusted accordingly.

    v2: Also move the corresponding put from ->lastclose to ->unload.

    Cc: Sascha Hauer <s.hauer@pengutronix.de>
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
    Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Signed-off-by: Dave Airlie <airlied@redhat.com>

,then the probe error does not happen.

Will look into in it and discuss at the dri-devel at lists.freedesktop.org list.
