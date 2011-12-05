From: daniel@ffwll.ch (Daniel Vetter)
Date: Mon, 5 Dec 2011 23:33:36 +0100
Subject: [RFC v2 1/2] dma-buf: Introduce dma buffer sharing mechanism
In-Reply-To: <CAF6AEGto-+oSqguuWyPunUbtE65GpNiXh21srQzrChiBQMb1Nw@mail.gmail.com>
References: <1322816252-19955-1-git-send-email-sumit.semwal@ti.com>
 <1322816252-19955-2-git-send-email-sumit.semwal@ti.com>
 <201112051718.48324.arnd@arndb.de>
 <CAF6AEGvyWV0DM2fjBbh-TNHiMmiLF4EQDJ6Uu0=NkopM6SXS6g@mail.gmail.com>
 <CAKMK7uHw3OpMAtVib=e=s_us9Tx9TebzehGg59d4-g9dUXr+pQ@mail.gmail.com>
 <CAF6AEGto-+oSqguuWyPunUbtE65GpNiXh21srQzrChiBQMb1Nw@mail.gmail.com>
Message-ID: <CAKMK7uFpQfAkoEqAJc8hX6k_kOsXR=u5O=fgyaNfaDM89cciSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2011 at 04:11:46PM -0600, Rob Clark wrote:
> On Mon, Dec 5, 2011 at 3:23 PM, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Mon, Dec 05, 2011 at 02:46:47PM -0600, Rob Clark wrote:
> >> I sort of preferred having the DMABUF shim because that lets you pass
> >> a buffer around userspace without the receiving code knowing about a
> >> device specific API. ?But the problem I eventually came around to: if
> >> your GL stack (or some other userspace component) is batching up
> >> commands before submission to kernel, the buffers you need to wait for
> >> completion might not even be submitted yet. ?So from kernel
> >> perspective they are "ready" for cpu access. ?Even though in fact they
> >> are not in a consistent state from rendering perspective. ?I don't
> >> really know a sane way to deal with that. ?Maybe the approach instead
> >> should be a userspace level API (in libkms/libdrm?) to provide
> >> abstraction for userspace access to buffers rather than dealing with
> >> this at the kernel level.
> >
> > Well, there's a reason GL has an explicit flush and extensions for sync
> > objects. It's to support such scenarios where the driver batches up gpu
> > commands before actually submitting them.
>
> Hmm.. what about other non-GL APIs..  maybe vaapi/vdpau or similar?
> (Or something that I haven't thought of.)

They generally all have a concept of when they've actually commited the
rendering to an X pixmap or egl image. Usually it's rather implicit, e.g.
the driver will submit any outstanding batches before returning from any
calls.
-Daniel
-- 
Daniel Vetter
Mail: daniel at ffwll.ch
Mobile: +41 (0)79 365 57 48
