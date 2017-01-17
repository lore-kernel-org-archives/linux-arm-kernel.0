From: robert.richter@cavium.com (Robert Richter)
Date: Tue, 17 Jan 2017 11:00:15 +0100
Subject: [PATCH v3] arm64: mm: Fix NOMAP page initialization
In-Reply-To: <20170113131500.GS4930@rric.localdomain>
References: <20161216165437.21612-1-rrichter@cavium.com>
 <CAKv+Gu_SmTNguC=tSCwYOL2kx-DogLvSYRZc56eGP=JhdrUOsA@mail.gmail.com>
 <c74d6ec6-16ba-dccc-3b0d-a8bedcb46dc5@linaro.org>
 <cbbf14fd-a1cc-2463-ba67-acd6d61e9db1@linaro.org>
 <CAKv+Gu8-+0LUTN0+8OGWRhd22Ls5cMQqTJcjKQK_0N=Uc-0jog@mail.gmail.com>
 <20170109115320.GI4930@rric.localdomain>
 <20170112160535.GF13843@arm.com>
 <20170112185825.GE5020@rric.localdomain>
 <20170113091903.GA22538@arm.com>
 <20170113131500.GS4930@rric.localdomain>
Message-ID: <20170117100015.GG5020@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13.01.17 14:15:00, Robert Richter wrote:
> On 13.01.17 09:19:04, Will Deacon wrote:
> > On Thu, Jan 12, 2017 at 07:58:25PM +0100, Robert Richter wrote:
> > > On 12.01.17 16:05:36, Will Deacon wrote:
> > > > On Mon, Jan 09, 2017 at 12:53:20PM +0100, Robert Richter wrote:
> > > 
> > > > > Kernel compile times (3 runs each):
> > > > > 
> > > > > pfn_valid_within():
> > > > > 
> > > > > real    6m4.088s
> > > > > user    372m57.607s
> > > > > sys     16m55.158s
> > > > > 
> > > > > real    6m1.532s
> > > > > user    372m48.453s
> > > > > sys     16m50.370s
> > > > > 
> > > > > real    6m4.061s
> > > > > user    373m18.753s
> > > > > sys     16m57.027s
> > > > 
> > > > Did you reboot the machine between each build here, or only when changing
> > > > kernel? If the latter, do you see variations in kernel build time by simply
> > > > rebooting the same Image?
> > > 
> > > I built it in a loop on the shell, so no reboots between builds. Note
> > > that I was building the kernel in /dev/shm to not access harddisks. I
> > > think build times should be comparable then since there is no fs
> > > caching.
> > 
> > I guess I'm really asking what the standard deviation is if you *do* reboot
> > between builds, using the same kernel. It's hard to tell whether the numbers
> > are due to the patches, or just because of noise incurred by the way things
> > happen to initialise.
> 
> Ok, I am going to test this.

See below the data for a test with reboots between every 3 builds (9
builds per kernel). Though some deviation can be seen between reboots
there is a trend.

-Robert



pfn_valid_within(), boot #1:

real	6m0.007s
user	372m55.709s
sys	16m45.962s

real	5m58.718s
user	372m58.852s
sys	16m47.675s

real	5m58.481s
user	372m56.172s
sys	16m46.953s

pfn_valid_within(), Boot #2:

real	6m1.163s
user	372m57.282s
sys	16m52.025s

real	6m0.562s
user	373m4.957s
sys	16m52.847s

real	6m0.030s
user	372m54.710s
sys	16m54.516s

pfn_valid_within(), Boot #3:

real	6m1.784s
user	373m13.379s
sys	16m48.388s

real	5m58.579s
user	373m10.403s
sys	16m47.628s

real	5m59.151s
user	373m0.084s
sys	16m50.634s

early_pfn_valid(), Boot #1:

real	5m59.902s
user	372m57.201s
sys	16m42.157s

real	5m59.510s
user	372m59.762s
sys	16m47.331s

real	5m58.559s
user	372m46.530s
sys	16m49.010s

early_pfn_valid(), Boot #2:

real	6m0.652s
user	373m10.785s
sys	16m25.138s

real	5m58.663s
user	373m4.498s
sys	16m28.262s

real	5m57.675s
user	373m6.174s
sys	16m28.653s

early_pfn_valid(), Boot #3:

real	5m59.680s
user	373m4.007s
sys	16m26.781s

real	5m58.234s
user	372m58.895s
sys	16m26.957s

real	5m58.707s
user	372m40.546s
sys	16m29.345s
