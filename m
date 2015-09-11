From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Sep 2015 13:24:23 +0100
Subject: [PATCH v4 21/22] driver core: Start processing deferred probes
 earlier
In-Reply-To: <1441628627-5143-22-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-22-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150911122423.GS12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2015 at 02:23:46PM +0200, Tomeu Vizoso wrote:
> Some initcalls in the late level assume that some devices will have
> already probed without explicitly checking for that.
> 
> After the recent move to defer most device probes when they are
> registered, pressure increased in the late initcall level.
> 
> By starting the processing of the deferred queue in device_initcall_sync
> we increase the chances that the initcalls mentioned before will find
> the devices they depend on to have already probed.

Which cases do we have that are outside the driver model and thus
affected by this?  USB gadgets are one case I'm aware of, and cpufreq is
still problematic.  I'm wondering if it might be tractable to address
the actual problems with the remaining reliance on init ordering here.

I'm also wondering if we might end up running into situations where this
makes the problem with havinng to defer probes more of an issue on some
systems - since we start trying earlier while we are still doing our
first pass initialisation we could end up deferring some device then
retrying it a bunch of times while going through the earlier phases of
init as we continue to register more devices.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150911/7fcdd61e/attachment.sig>
