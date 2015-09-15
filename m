From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 15 Sep 2015 13:01:25 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <20150915101220.GQ21084@n2100.arm.linux.org.uk> (Russell King's
 message of "Tue, 15 Sep 2015 11:12:20 +0100")
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl> <1441709778.13536.8.camel@pengutronix.de>
 <m3bnd52y4s.fsf@t19.piap.pl> <m337yg2ip4.fsf@t19.piap.pl>
 <20150915101220.GQ21084@n2100.arm.linux.org.uk>
Message-ID: <m3wpvs0wvu.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>> 1024 x 768 for now. I noticed a strange thing: XvShmPutImage() usually
>> takes (much) less than 4 milliseconds, but every 315 frames, it takes
>> much longer (when started, it takes 1259 frames). The following is with
>> constant image, i.e., not altered between frames. Source attached (one
>> may need to change xv_port variable).
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> 1. Don't hard code the Xv port ID (worth mentioning somewhere so people
>    testing it don't spend something like a quarter of an hour trying to
>    debug why it doesn't work.)

Well, I actually mentioned it.


So this means the delay was only "grouped" by the X protocol, and it
won't be magically faster.

> Now, running on Dove overlay, I see about 17ms being the average time,
> which is slightly longer than the vsync.

> Let's not forget that Dove hardware is slower than iMX6, so I think that
> iMX6 should manage to comfortably achieve the 16.6ms required for
> frame-by-frame display from your program.

Interestingly, i.MX6 seems to achive about 3.2 ms, which is much faster.
If not for the missing color planes (and scaling), it would be perfect.
(and I only need 30 FPS).

> Now, as for using the GPU, X server analysis:
> - Again about 1ms between select() and read() of the event
> - 1ms to the first WAIT_VBLANK ioctl on the display adapter to read the
>   last VSYNC time
> - 200us later to map the user pointer
> - 300us to the WAIT_VBLANK ioctl to wait for the vblank (which takes in this
>   instance 3.5ms to fire)
> - 130us to first attempt to submit the GPU queue, which returns -EAGAIN
>   after 6.4ms
> - second attempt takes 9.5ms to complete successfully
> - 1ms (with intervening SIGALRM handler) to wait for the GPU to finish,
>   which takes 11.5ms
> - 450us to ask DRM to release the user pointer buffer, which takes 9.4ms
> - 1ms (with intervening SIGALRM handler) to report completion of the operation
> - The X server then takes about 4ms to get back to calling select().

Sure, I know it has to be slower.

So this takes (on Dove) about 50 ms (at 1024x768), thus is way too slow
to display video at this (or higher) resolution and frame rate.
On i.MX6q, it takes about 66 - 74 ms, depending on actual clock speed
(frequency scaling, up to 1 GHz).

Thanks for testing.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
