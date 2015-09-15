From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 15 Sep 2015 10:24:55 +0200
Subject: I.MX6 HDMI support in v4.2
In-Reply-To: <m3bnd52y4s.fsf@t19.piap.pl> ("Krzysztof
 \=\?utf-8\?Q\?Ha\=C5\=82as\?\=
 \=\?utf-8\?Q\?a\=22's\?\= message of
 "Mon, 14 Sep 2015 10:39:15 +0200")
References: <m3bnde5whx.fsf@t19.piap.pl>
 <20150907112555.GS21084@n2100.arm.linux.org.uk>
 <m337yp5gvv.fsf@t19.piap.pl> <1441709778.13536.8.camel@pengutronix.de>
 <m3bnd52y4s.fsf@t19.piap.pl>
Message-ID: <m337yg2ip4.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Testing Linux v4.2 + PLL5 DTS patch (for HDMI output with enabled LVDS).
> Using mplayer with YUV420 (DRM Xvideo would probably work with packed
> UYVY-alike formats but I need YUV420 because H.264 decoder produces it).
> The driver is git://ftp.arm.linux.org.uk/~rmk/xf86-video-armada.git,
> branch unstable-devel, and it uses
> git://ftp.arm.linux.org.uk/~rmk/libdrm-armada.git/.
>
> 	IMX DRM Xvideo output:
>
> Only unscaled video: no color (luminance is good but the color
> components are green). The driver doesn't use color information.

1024 x 768 for now. I noticed a strange thing: XvShmPutImage() usually
takes (much) less than 4 milliseconds, but every 315 frames, it takes
much longer (when started, it takes 1259 frames). The following is with
constant image, i.e., not altered between frames. Source attached (one
may need to change xv_port variable).

Now what?

XVideo: using adaptor #0, port 85
Image ID 30323449 1024x768 data_size 1179648 num_planes 3 pitches 1024 512 512 data 0x76b86000
Frame#  frame count from the last such event
  vvvv   vvvv
  1259   1259: Took 0.665640667 s, avg 0.000530765 s
  1574    315: Took 0.501529334 s, avg 0.000743380 s
  1889    315: Took 0.496656667 s, avg 0.000882432 s
  2204    315: Took 0.496726667 s, avg 0.000981782 s
  2519    315: Took 0.496672333 s, avg 0.001056277 s
  2834    315: Took 0.496910000 s, avg 0.001114301 s
  3149    315: Took 0.497260667 s, avg 0.001160832 s
  3464    315: Took 0.499651334 s, avg 0.001199600 s
  3779    315: Took 0.495202334 s, avg 0.001230718 s
  4094    315: Took 0.499449667 s, avg 0.001258081 s
  4409    315: Took 0.525910333 s, avg 0.001287535 s
  4724    315: Took 0.510400000 s, avg 0.001309786 s
  5039    315: Took 0.541753334 s, avg 0.001335467 s
  5354    315: Took 0.537526666 s, avg 0.001357350 s
  5669    315: Took 0.542006000 s, avg 0.001377594 s
  5984    315: Took 0.539530333 s, avg 0.001395288 s
  6299    315: Took 0.541836000 s, avg 0.001411578 s
  6614    315: Took 0.541556333 s, avg 0.001426275 s
  6929    315: Took 0.543209666 s, avg 0.001439874 s
  7244    315: Took 0.540764000 s, avg 0.001451956 s
  7559    315: Took 0.512616666 s, avg 0.001459303 s
  7874    315: Took 0.541380000 s, avg 0.001469720 s
  8189    315: Took 0.535251333 s, avg 0.001478584 s
  8504    315: Took 0.536773334 s, avg 0.001486975 s
  8819    315: Took 0.521379000 s, avg 0.001493018 s
  9134    315: Took 0.492112667 s, avg 0.001495438 s
  9449    315: Took 0.616766000 s, avg 0.001510886 s
  9764    315: Took 0.492945666 s, avg 0.001512657 s
 10079    315: Took 0.492615000 s, avg 0.001514286 s
 10394    315: Took 0.493068000 s, avg 0.001515858 s
 10709    315: Took 0.496838000 s, avg 0.001517693 s
 11024    315: Took 0.516352333 s, avg 0.001521193 s
 11339    315: Took 0.500899333 s, avg 0.001523138 s
 11654    315: Took 0.494034334 s, avg 0.001524386 s
 11969    315: Took 0.492401000 s, avg 0.001525430 s
 12284    315: Took 0.505440000 s, avg 0.001527485 s
 12599    315: Took 0.511242666 s, avg 0.001529898 s
 12914    315: Took 0.493489333 s, avg 0.001530816 s

With etnaviv Xvideo, the effect is similar but much worse:

> 	rmk/drm-etnaviv-devel:
>
> With unscaled video, the only visible problem is tearing in the middle
> of the screen (unability to sync with screen refresh).

XVideo: using adaptor #1, port 90
Image ID 30323449 1024x768 data_size 1179648 num_planes 3 pitches 1024 512 512 data 0x76b8d000
  1259   1259: Took 18.864969669 s, avg 0.014974047 s
  1574    315: Took 20.758470002 s, avg 0.025159601 s
  1889    315: Took 20.720458336 s, avg 0.031929827 s
  2204    315: Took 20.831572669 s, avg 0.036815999 s
  2519    315: Took 20.807073336 s, avg 0.040470906 s
  2834    315: Took 20.789431003 s, avg 0.043307485 s
  3149    315: Took 20.809190003 s, avg 0.045582932 s
  3464    315: Took 20.803870003 s, avg 0.047443189 s
  3779    315: Took 20.798422002 s, avg 0.048991905 s
  4094    315: Took 20.809182336 s, avg 0.050304985 s
  4409    315: Took 20.812659336 s, avg 0.051431326 s
  4724    315: Took 20.816828669 s, avg 0.052408363 s
  5039    315: Took 20.814890002 s, avg 0.053262894 s
  5354    315: Took 20.803809003 s, avg 0.054014822 s
  5669    315: Took 20.798233669 s, avg 0.054682176 s
  5984    315: Took 20.809503336 s, avg 0.055281168 s
  6299    315: Took 20.814339002 s, avg 0.055821065 s
  6614    315: Took 20.812699003 s, avg 0.056309294 s
  6929    315: Took 20.800363670 s, avg 0.056751361 s
  7244    315: Took 20.814518669 s, avg 0.057156941 s
  7559    315: Took 20.814902002 s, avg 0.057528773 s
  7874    315: Took 20.814914336 s, avg 0.057870859 s
  8189    315: Took 20.803919669 s, avg 0.058185288 s
  8504    315: Took 20.807010336 s, avg 0.058476760 s
  8819    315: Took 20.855880669 s, avg 0.058752983 s
  9134    315: Took 20.809301669 s, avg 0.059005029 s
  9449    315: Took 26.004653003 s, avg 0.059790071 s
  9764    315: Took 20.796989002 s, avg 0.059991163 s
 10079    315: Took 20.798379670 s, avg 0.060179803 s
 10394    315: Took 20.809240335 s, avg 0.060358055 s
 10709    315: Took 20.814655003 s, avg 0.060526351 s
 11024    315: Took 20.803836002 s, avg 0.060684046 s
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland

#include <ctype.h>
#include <signal.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>
#include <sys/shm.h>
#include <sys/time.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/Xatom.h>
#include <X11/extensions/Xv.h>
#include <X11/extensions/Xvlib.h>
#include <X11/extensions/XShm.h>

#define IMAGE_FORMAT_NAME "planar I420"
#define IMAGE_FORMAT      0x30323449
#define PIXEL_FORMAT      AV_PIX_FMT_YUV420P

static Display *display;
static Window window;
static XShmSegmentInfo shminfo;
static XvImage *image;
static GC gc;
static unsigned w, h;
static unsigned xv_port = 90;

static void test_xv(void)
{
	fprintf(stderr, "Image ID %X %ux%u data_size %u num_planes %u pitches %u %u %u data %p\n",
			image->id, image->width, image->height, image->data_size, image->num_planes, image->pitches[0], image->pitches[1], image->pitches[2], image->data);

	struct timespec ts;
	if (clock_gettime(CLOCK_MONOTONIC, &ts)) {
		fprintf(stderr, "clock_gettime(MONOTONIC) failed: %m\n");
		exit(1);
	}

	unsigned long long prev_t = (unsigned long long)ts.tv_sec * 1000 * 1000 * 1000 + ts.tv_nsec;
	unsigned long long start_t = prev_t;
	unsigned count = 0, prev_count = 0;

	while (1) {
		memset(image->data, count, image->data_size);
		XvShmPutImage(display, xv_port, window, gc, image, 0, 0, w, h, 0, 0, w, h, True);

		if (clock_gettime(CLOCK_MONOTONIC, &ts)) {
			fprintf(stderr, "clock_gettime(MONOTONIC) failed: %m\n");
			exit(1);
		}
		unsigned long long t = (unsigned long long)ts.tv_sec * 1000 * 1000 * 1000 + ts.tv_nsec;
		if (t - prev_t > 4 * 1000 * 1000) {
			fprintf(stdout, "%6u %6u: Took %llu.%09llu s, avg %llu.%09llu s\n",
					count, count - prev_count,
					(t - prev_t) / (1000 * 1000 * 1000),
					(t - prev_t) % (1000 * 1000 * 1000),
					(t - start_t) / (count + 1) / (1000 * 1000 * 1000),
					(t - start_t) / (count + 1) % (1000 * 1000 * 1000));
			prev_count = count;
		}
		prev_t = t;
		count++;
	}
}

int main(void)
{
	display = XOpenDisplay(NULL);
	if (!display) {
		fprintf(stderr, "Unable to open X11 display\n");
		exit(1);
	}

	unsigned int screen = DefaultScreen(display);
	Window rdw;
	unsigned rb, rd;
	int x, y;
	if (!XGetGeometry(display, XRootWindow(display, screen), &rdw, &x, &y, &w, &h, &rb, &rd)) {
		fprintf(stderr, "Unable to get root window geometry\n");
		exit(1);
	}

	fprintf(stderr, "Creating %ux%u window at %ux%u\n", w, h, x, y);
	window = XCreateSimpleWindow(display, XRootWindow(display, screen), x, y, w, h, 0, 0, 0);

	static XClassHint class_hints = {.res_name = "Xvideo test", .res_class = "XVideo test"};
	XSetClassHint(display, window, &class_hints);

	XMapWindow(display, window);
	XStoreName(display, window, "Xvideo test");
	XSetIconName(display, window, "Xvideo test");
	XFlush(display);

	// Search for Xvideo ports
	XvAdaptorInfo *info;
	unsigned adaptors;
	if (XvQueryAdaptors(display, window, &adaptors, &info) != Success) {
		fprintf(stderr, "No XVideo adaptors found\n");
		exit(1);
	}

	unsigned cnt, found = 0;
	for (cnt = 0; cnt < adaptors; cnt++) {
		XvAdaptorInfo *adaptor = &info[cnt];
#if 0
		fprintf(stderr, "Xv adaptor: %s, port base %lu, count %lu, type 0x%X, %lu format(s)\n",
				adaptor->name, adaptor->base_id, adaptor->num_ports, adaptor->type, adaptor->num_formats);
		for (unsigned cnt1 = 0; cnt1 < adaptor->num_formats; cnt1++) {
			XvFormat *format = &adaptor->formats[cnt1];
			fprintf(stderr, "   depth %u, visual ID 0x%lX\n", format->depth, format->visual_id);
		}
#endif

		for (unsigned cnt1 = 0; cnt1 < adaptor->num_ports; cnt1++) {
			int num_formats;
			XvImageFormatValues *image_formats = XvListImageFormats(display, adaptor->base_id + cnt1, &num_formats);
			for (int cnt2 = 0; cnt2 < num_formats; cnt2++) {
				XvImageFormatValues *image_format = &image_formats[cnt2];

#if 0
				fprintf(stderr, "   Port %lu: type %i ID 0x%X (%c%c%c%c) byte order %i\n",
						adaptor->base_id + cnt1, image_format->type, image_format->id,
						isprint( image_format->id        & 0xFF) ?  image_format->id        & 0xFF : '?',
						isprint((image_format->id >>  8) & 0xFF) ? (image_format->id >>  8) & 0xFF : '?',
						isprint((image_format->id >> 16) & 0xFF) ? (image_format->id >> 16) & 0xFF : '?',
						isprint((image_format->id >> 24) & 0xFF) ? (image_format->id >> 24) & 0xFF : '?',
						image_format->byte_order);
#endif

				if (!found) {
					if (xv_port) {
						if (xv_port >= adaptor->base_id && xv_port < adaptor->base_id + adaptor->num_ports) {
							if (!(adaptor->type & XvImageMask))
								fprintf(stderr, "XVideo port %u doesn't have XvImageMask capability\n", xv_port);
							else if (image_format->id == IMAGE_FORMAT)
								found = 1;
							else if (xv_port == adaptor->base_id + adaptor->num_ports - 1)
								fprintf(stderr, "XVideo port %u doesn't support " IMAGE_FORMAT_NAME "image format\n", xv_port);
						}
					} else {
						if (adaptor->type & XvImageMask && adaptor->num_ports && image_format->id == IMAGE_FORMAT) {
							xv_port = adaptor->base_id;
							found = 1;
						}
					}
					if (found)
						fprintf(stderr, "XVideo: using adaptor #%u, port %u\n", cnt, xv_port);
				}
			}

			XFree(image_formats);
		}
	}
	XvFreeAdaptorInfo(info);

	if (!found) {
		fprintf(stderr, "No valid XVideo adaptor found\n");
		exit(1);
	}

	image = XvShmCreateImage(display, xv_port, IMAGE_FORMAT, NULL, w, h, &shminfo);
	shminfo.shmid = shmget(IPC_PRIVATE, image->data_size, IPC_CREAT | 0777);
	if (shminfo.shmid < 0)
		exit(1);

	shminfo.shmaddr = image->data = shmat(shminfo.shmid, 0, 0);
	if (shminfo.shmaddr == (void*) -1)
		exit(1);

	shminfo.readOnly = False;

	if (!XShmAttach(display, &shminfo))
		exit(1);

	gc = XCreateGC(display, window, 0, 0);
	test_xv();
	exit(0);
}
