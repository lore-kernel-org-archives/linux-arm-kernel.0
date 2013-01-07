From: will.deacon@arm.com (Will Deacon)
Date: Mon, 7 Jan 2013 11:58:36 +0000
Subject: CoreSight framework and drivers
In-Reply-To: <20130103180643.GA30277@pratikp-linux.qualcomm.com>
References: <1355858365-11849-1-git-send-email-pratikp@codeaurora.org>
 <20121219112314.GA26329@mudshark.cambridge.arm.com>
 <50D1F37E.6000804@ti.com>
 <20121219212431.GC23594@pratikp-linux.qualcomm.com>
 <50D34EE5.8090407@ti.com>
 <20121220195127.GA14877@pratikp-linux.qualcomm.com>
 <50D3972E.4030607@ti.com>
 <20121221221828.GA2658@pratikp-linux.qualcomm.com>
 <20121223113239.GG16237@mudshark.cambridge.arm.com>
 <20130103180643.GA30277@pratikp-linux.qualcomm.com>
Message-ID: <20130107115836.GB13542@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 06:06:43PM +0000, Pratik Patel wrote:
> On Sun, Dec 23, 2012 at 11:32:39AM +0000, Will Deacon wrote:
> > On Fri, Dec 21, 2012 at 10:18:28PM +0000, Pratik Patel wrote:
> > > What user interface do you plan to provide for the CTI? Maybe
> > > something consistent with other CoreSight components in sysfs to
> > > allow users to enable, disable, map and unmap ???
> > > 
> > > Please let me know your thoughts.
> > 
> > Rather than have your current approach of dev nodes + sysfs config files for
> > each coresight device, I think it might be better to follow something closer
> > to ftrace and stick per-device directories under debugfs/coresight/. Then you
> > can have a pipe file and some config files in the same directory for each
> > component. You also don't need to do any mapping operations with this (just
> > post-process the stream directly).
> > 
> 
> Thanks for the suggestion. I had initially debated between debugfs
> and sysfs but chose sysfs + dev nodes since using device attributes
> relieves the drivers from manually managing directories and files,
> its taken care of by the device and sysfs layers. Moreover, since
> these are physical devices, device attributes made sense at the
> time.
> 
> The map and unmap I was referring to was for the CTI trigger
> mappings. Dev nodes are currently intended to provide the raw
> data collected in the sinks.
> 
> Whats the advantage in using debugfs here?

The main things I like about debugfs are (a) it's a text-driven interface
and easy to script with and (b) it matches what we do for ftrace.

Furthermore, it means that subtle differences between devices can be hidden
in the driver and not require different vendor tools for parsing the trace
data.

Will
