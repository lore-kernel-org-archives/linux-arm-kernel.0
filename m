From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Feb 2017 22:44:53 +0000
Subject: [PATCH v3 16/24] media: Add i.MX media core driver
In-Reply-To: <1483755102-24785-17-git-send-email-steve_longerbeam@mentor.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-17-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <20170202224453.GY27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 06:11:34PM -0800, Steve Longerbeam wrote:
> +struct imx_media_dev {
> +	struct media_device md;
> +	struct v4l2_device  v4l2_dev;

This is similarly buggy.

struct v4l2_device {
        struct device *dev;
#if defined(CONFIG_MEDIA_CONTROLLER)
        struct media_device *mdev;
#endif
        struct list_head subdevs;
        spinlock_t lock;
        char name[V4L2_DEVICE_NAME_SIZE];
        void (*notify)(struct v4l2_subdev *sd,
                        unsigned int notification, void *arg);
        struct v4l2_ctrl_handler *ctrl_handler;
        struct v4l2_prio_state prio;
        struct kref ref;
        void (*release)(struct v4l2_device *v4l2_dev);
};

Notice the kref and release function.  This is the only way the
memory backing "struct v4l2_device" may be released.  If you wish to
embed this structure into another structure, then the lifetime of
that other structure is determined by this one.  IOW, when this
release function is called, only then may you kfree() the memory
backing struct imx_media_dev.

> +	struct device *dev;

And... do you need all these struct device pointers?

        imxmd->dev = dev;
        imxmd->md.dev = dev;

As media_device already contains a pointer, can't you re-use that?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
