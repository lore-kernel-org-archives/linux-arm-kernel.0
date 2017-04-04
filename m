From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Apr 2017 17:34:55 +0100
Subject: [PATCH 2/2] [media] cec: Handle RC capability more elegantly
In-Reply-To: <20170404161005.20884-2-lee.jones@linaro.org>
References: <20170404161005.20884-1-lee.jones@linaro.org>
 <20170404161005.20884-2-lee.jones@linaro.org>
Message-ID: <20170404163455.GD7909@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 05:10:05PM +0100, Lee Jones wrote:
> @@ -237,7 +241,6 @@ struct cec_adapter *cec_allocate_adapter(const struct cec_adap_ops *ops,
>  	if (!(caps & CEC_CAP_RC))
>  		return adap;
>  
> -#if IS_REACHABLE(CONFIG_RC_CORE)
>  	/* Prepare the RC input device */
>  	adap->rc = rc_allocate_device(RC_DRIVER_SCANCODE);
>  	if (!adap->rc) {

The above, coupled with patch 1:

+#ifdef CONFIG_RC_CORE
 struct rc_dev *rc_allocate_device(enum rc_driver_type);
+#else
+static inline struct rc_dev *rc_allocate_device(int unused)
+{
+       return ERR_PTR(-EOPNOTSUPP);
+}
+#endif

is really not nice.  You claim that this is how stuff is done elsewhere
in the kernel, but no, it isn't.  Look at debugfs.

You're right that debugfs returns an error pointer when it's not
configured.  However, the debugfs dentry is only ever passed back into
the debugfs APIs, it is never dereferenced by the caller.

That is not the case here.  The effect if your change is that the
following dereferences will oops the kernel.  This is unacceptable for
a feature that is deconfigured.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
