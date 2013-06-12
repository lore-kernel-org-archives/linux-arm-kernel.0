From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jun 2013 00:00:57 +0100
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <20130612194021.GX18614@n2100.arm.linux.org.uk>
References: <20130610225607.GE18614@n2100.arm.linux.org.uk>
 <CAF6AEGvAqF=SbxW=D_ymbW+w9SEqfouxPsVZEsctdk-iM79L5w@mail.gmail.com>
 <CAPM=9twJGgYiXxQyaXCnYd+bUPFv+P92qGdmJ39_4z29==4F2g@mail.gmail.com>
 <20130610233611.GK18614@n2100.arm.linux.org.uk>
 <CAPM=9tz6p2rhjNUg7ednT09A+dztbYskF32QkZeaCi_qrH8ipw@mail.gmail.com>
 <20130612134845.GQ18614@n2100.arm.linux.org.uk>
 <CAF6AEGs4GLkBePQUd_Bh4z_Hwv8kacaEQSMSVSj4rw=ezQA66Q@mail.gmail.com>
 <20130612164914.GT18614@n2100.arm.linux.org.uk>
 <20130612170512.GU18614@n2100.arm.linux.org.uk>
 <20130612194021.GX18614@n2100.arm.linux.org.uk>
Message-ID: <20130612230057.GY18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

And here's another one - look carefully at this path:

                buf = dev->driver->gem_prime_export(dev, obj, flags);
                if (IS_ERR(buf)) {
                        /* normally the created dma-buf takes ownership of the ref,
                         * but if that fails then drop the ref
                         */
                        drm_gem_object_unreference_unlocked(obj);
                        mutex_unlock(&file_priv->prime.lock);
                        return PTR_ERR(buf);
                }
                obj->export_dma_buf = buf;
                *prime_fd = dma_buf_fd(buf, flags);
        }
        /* if we've exported this buffer the cheat and add it to the import list
         * so we get the correct handle back
         */
        ret = drm_prime_add_imported_buf_handle(&file_priv->prime,
                        obj->export_dma_buf, handle);
        if (ret) {
                drm_gem_object_unreference_unlocked(obj);
                mutex_unlock(&file_priv->prime.lock);
                return ret;
        }

So in the event of drm_prime_add_imported_buf_handle() returning an error,
we return that error to our caller (which will eventually be userspace)
saying that we failed.

However, we've already setup the export and obtained an fd for it, which
we resultingly now leak in that situation.

Now, second problem here - consider what happens if you ask for the same
object to be exported a second (or more) times.  Note that
obj->export_dma_buf will now be set, so we take a different path through
this code:

        if (obj->export_dma_buf) {
                get_dma_buf(obj->export_dma_buf);
                *prime_fd = dma_buf_fd(obj->export_dma_buf, flags);
                drm_gem_object_unreference_unlocked(obj);
	} else {
	}
        /* if we've exported this buffer the cheat and add it to the import list
         * so we get the correct handle back
         */
        ret = drm_prime_add_imported_buf_handle(&file_priv->prime,
                        obj->export_dma_buf, handle);
        if (ret) {
                drm_gem_object_unreference_unlocked(obj);
                mutex_unlock(&file_priv->prime.lock);
                return ret;
        }

Now, if I in a loop in userspace doing this:

	do {
		drmPrimeHandleToFD(..., &fd);
		close(fd);
	} while (1);

How long do you think it might take to exhaust the kmalloc() inside
drm_prime_add_imported_buf_handle() ?

It's not even trivially fixable, because drm_gem_dmabuf_release() doesn't
call drm_prime_remove_imported_buf_handle() because it has no knowledge
of the drm_prime_file_private structure to search for these things...
