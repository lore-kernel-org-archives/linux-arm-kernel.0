From: ming.lei@canonical.com (Ming Lei)
Date: Thu, 20 Jun 2013 23:13:47 +0800
Subject: [RFC PATCH v1 1/6] USB: HCD: support giveback of URB in tasklet
 context
In-Reply-To: <Pine.LNX.4.44L0.1306201046440.2063-100000@iolanthe.rowland.org>
References: <CACVXFVOMYA9e2qiJoFCx+v7=fSWpjwpha5hKdcxX+4s5qAT83w@mail.gmail.com>
 <Pine.LNX.4.44L0.1306201046440.2063-100000@iolanthe.rowland.org>
Message-ID: <CACVXFVPPF=DNp0dpypoZ=OifkfnCgWJKpQHMv4xE8PmBk8RiHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 10:59 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> By the way, did you consider the race that Oliver pointed out?  When an
> HCD is removed, all the outstanding URBs for all devices on its bus get
> cancelled.  The core waits until the urb_list for each endpoint is
> empty.

This should be enough since during remove path usbcore will wait for all
URBs' completion which is only triggered by tasklet, so once all URBs are
finished, the tasklet list has been empty already.

>
> In the past this was good enough.  But now it looks like we will also
> need to wait until the tasklet lists are empty and the tasklets aren't
> running before they get killed.  Your __exit_giveback_urb_bh() routine
> doesn't seem to do that.
>
> (Probably it's sufficient to wait until the tasklet lists are empty.  I
> assume tasklet_kill() won't stop a tasklet that's currently running.)

>From the implementation of tasklet_kill(), it will wait for the completion
of the tasklet.

Actually the tasklet_kill() should not be necessary, I think.


Thanks,
--
Ming Lei
