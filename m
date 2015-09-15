From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Sep 2015 11:12:20 +0100
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <m337yg2ip4.fsf@t19.piap.pl>
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl>
 <1441709778.13536.8.camel@pengutronix.de>
 <m3bnd52y4s.fsf@t19.piap.pl> <m337yg2ip4.fsf@t19.piap.pl>
Message-ID: <20150915101220.GQ21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2015 at 10:24:55AM +0200, Krzysztof Ha?asa wrote:
> 1024 x 768 for now. I noticed a strange thing: XvShmPutImage() usually
> takes (much) less than 4 milliseconds, but every 315 frames, it takes
> much longer (when started, it takes 1259 frames). The following is with
> constant image, i.e., not altered between frames. Source attached (one
> may need to change xv_port variable).

Testing on Dove and Armada DRM, I've had to make several changes to your
program:

1. Don't hard code the Xv port ID (worth mentioning somewhere so people
   testing it don't spend something like a quarter of an hour trying to
   debug why it doesn't work.)

2. Added _GNU_SOURCE at the top to get various structs and functions
   that the program uses.

3. Added a line detailing the GCC flags to be used

4. A description of what the program is doing would be nice.  For the
   record, it appears to try and call XvShmPutImage() as quickly as
   possible, recording the absolute time between calls, and reporting
   when it is more than 4ms.

5. Added a call to XSync(display, 1) after the call to XvShmPutImage()
   to ensure that the XvShmPutImage() gets pushed to the X server in a
   timely manner, doesn't sit in the applications X queue, and ensure
   that we wait for the X server to respond.

6. Extended the 4ms timeout to something sane, like 17ms.  If we're
   talking about synchronising to the vertical sync, then the period
   when we want to complain is when it takes much longer than that.

   If the display is synchronised to the vertical sync to avoid tearing,
   then you can only update the display once per vertical sync, and at
   60Hz, that's about 17ms.  At 50Hz, that's 20ms.

Now, running on Dove overlay, I see about 17ms being the average time,
which is slightly longer than the vsync.

Further analysis with strace of the X server (which pushes things up to
20ms average time):
- The X server takes about 1ms between select() indicating that there's
  an event available, and reading the event.
- It takes 14ms from reading the event to the DDX calling the DRM ioctl
  to display the image - mostly spent memcpy()'ing the image.
- 900us to return the response to the X client
- The X server then takes about 4ms to get back to calling select().

The big chunk of that is the memcpy() - that's something which can't be
eliminated for several reasons:
- With XvShm, the image buffer is shared between the X client and the
  X server.  The X server has no control over how the X client manipulates
  that buffer after the X server has returned from its call - however the
  displayed image must remain stable and free from manipulation until the
  next PutImage call.
- The X shm buffer can't be passed directly into DRM - DRM needs the
  image to be displayed to be in DRM buffer objects, which are then
  wrapped as frame buffers (a frame buffer can contain several buffer
  objects, one for each plane), and lastly the overlay plane updated
  with the new framebuffer.

Let's not forget that Dove hardware is slower than iMX6, so I think that
iMX6 should manage to comfortably achieve the 16.6ms required for
frame-by-frame display from your program.

Now, as for using the GPU, X server analysis:
- Again about 1ms between select() and read() of the event
- 1ms to the first WAIT_VBLANK ioctl on the display adapter to read the
  last VSYNC time
- 200us later to map the user pointer
- 300us to the WAIT_VBLANK ioctl to wait for the vblank (which takes in this
  instance 3.5ms to fire)
- 130us to first attempt to submit the GPU queue, which returns -EAGAIN
  after 6.4ms
- second attempt takes 9.5ms to complete successfully
- 1ms (with intervening SIGALRM handler) to wait for the GPU to finish,
  which takes 11.5ms
- 450us to ask DRM to release the user pointer buffer, which takes 9.4ms
- 1ms (with intervening SIGALRM handler) to report completion of the operation
- The X server then takes about 4ms to get back to calling select().

So, you can see that using the GPU is a much heavier and complex operation
all round.  The long delays in mapping and releasing the buffer are of
course the DMA mapping/unmapping of the buffer object to ensure that the
GPU can see the data in those buffers.

What's also notable is that it takes the GPU on the order of 10ms to do the
operation - it's actually two operations: a vertical filter blit followed
by a horizontal filter blit.  None of the Vivante GPUs that I've access to
support a single-pass filter blit scaling in both directions (the feature
bit for that is clear on both Dove's GC600 and iMX6 GC320 GPUs.)  I
suspect a Vivante GPU supporting that would take around half the time,
or better.

Of course, the time each of these operations take scales with the image
size, so an image half the width and height (which will be a quarter of
the size) will take a quarter of the time, and will be comfortably
within 17ms.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
