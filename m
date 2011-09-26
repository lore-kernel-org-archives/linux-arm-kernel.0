From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Sep 2011 15:16:43 +0100
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20110922184614.25419.84606.stgit@ponder>
References: <20110922184614.25419.84606.stgit@ponder>
Message-ID: <20110926141643.GK2946@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 12:51:23PM -0600, Grant Likely wrote:
> Allow drivers to report at probe time that they cannot get all the resources
> required by the device, and should be retried at a later time.

> This should completely solve the problem of getting devices
> initialized in the right order.  Right now this is mostly handled by
> mucking about with initcall ordering which is a complete hack, and
> doesn't even remotely handle the case where device drivers are in
> modules.  This approach completely sidesteps the issues by allowing
> driver registration to occur in any order, and any driver can request
> to be retried after a few more other drivers get probed.

So, one issue I did think of the other day while putting some support in
the regulator core for using this: what happens with devices which can
optionally use a resource but don't rely on it?  One example here is
that a lot of the MMC drivers have an optional regulator to control some
of the supplies for the cards.  If the reglator isn't there it won't be
used but it's not a blocker for anything.  Devices doing this would need
some way to figure out if they should -EBUSY or fail otherwise.
