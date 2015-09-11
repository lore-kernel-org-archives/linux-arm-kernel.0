From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 Sep 2015 13:10:24 +0100
Subject: [PATCH v4 07/22] regulator: core: Reduce critical area in
 _regulator_get
In-Reply-To: <1441628627-5143-8-git-send-email-tomeu.vizoso@collabora.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-8-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150911121024.GQ12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2015 at 02:23:32PM +0200, Tomeu Vizoso wrote:
> By moving the locking of regulator_list_mutex into regulator_dev_lookup,
> where it is iterated over. The reference count of the regulator's device
> is increased in case it's unregistered while in use.
> 
> In _regulator_get() the regulator_list_mutex mutex was held for most of
> the function, but that is only strictly needed to protect the list
> lookups.
> 
> This change would be useful if for example regulator devices could be
> registered on demand when a driver requests them. regulator_register()
> could end up being called from within _regulator_get while the lock on
> regulator_list_mutex is being held, causing a deadlock.

The fix for this is to convert the code to use the list maintained by
the driver core for regulator class to iterate the regulators rather
than fiddle about with the locking.  I'm pretty sure the current locking
has problems and I'm worried that this may make those problems worse.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150911/f2d92875/attachment.sig>
