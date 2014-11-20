From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Nov 2014 10:06:33 +0000
Subject: [PATCH v2] clk: Propagate prepare and enable when reparenting
 orphans
In-Reply-To: <20141120074514.GB30434@dtor-ws>
References: <1415408818-28028-1-git-send-email-dianders@chromium.org>
 <20141120023050.12298.26964@quantum>
 <CAD=FV=VZJ_iSFoW39kbahFSZ_Ta4Qf7zxaCnJMWFVWhXzsLrWw@mail.gmail.com>
 <20141120074514.GB30434@dtor-ws>
Message-ID: <20141120100633.GP4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 11:45:14PM -0800, Dmitry Torokhov wrote:
> On Wed, Nov 19, 2014 at 09:15:41PM -0800, Doug Anderson wrote:
> > I will defer to your wisdom here.  I agree that these are the two
> > primary solutions and I've picked one, but I have no idea which will
> > be more of a PITA in the long run.
> > 
> > Note: I'm not sure that anyone expects EPROBE_DEFER to be returned
> > from a clk_enable() (do they?).  It almost seems like the right answer
> > is to fail to allow anyone to clk_get() any clock that doesn't have a
> > path to root.
> 
> EPROBE_DEFER only makes sense in driver's probe paths and so I would be
> very against adding it to clk_enable() which is called from many places
> in the kernel. If we decide to go with EPROBE_DEFER then returning it
> from clk_get() seems like a much better choice since it is normally
> called during probing.

Absolutely correct.  EINVAL would be better for clk_prepare() since it
isn't something that can be recovered from by just retrying a bit later.

You're absolutely correct that EPROBE_DEFER has no business being returned
in any path other than a driver's probe function; it is not a user visible
error code, it is a special internal Linux error code which only the driver
model understands to mean "add this device to the deferred probe list and
try again a while later."  Userspace, especially, should never see this
error code.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
