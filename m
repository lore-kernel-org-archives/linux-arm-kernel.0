From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Feb 2018 12:35:42 +0100
Subject: [PATCH v5 05/20] firmware: arm_scmi: add scmi protocol bus to
 enumerate protocol devices
In-Reply-To: <1514904162-11201-6-git-send-email-sudeep.holla@arm.com>
References: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com>
 <1514904162-11201-6-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAK8P3a1wBBVZnd6ns5K-HhQ28WKAwVbaWsnmE+83SyOnTQt4_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 2, 2018 at 3:42 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

> +#ifdef CONFIG_ARM_SCMI_PROTOCOL
> +int scmi_driver_register(struct scmi_driver *driver,
> +                        struct module *owner, const char *mod_name);
> +void scmi_driver_unregister(struct scmi_driver *driver);
> +#else
> +static int scmi_driver_register(struct scmi_driver *driver,
> +                               struct module *owner, const char *mod_name)
> +{
> +       return -EINVAL;
> +}
> +static void scmi_driver_unregister(struct scmi_driver *driver) {}
> +#endif /* CONFIG_ARM_SCMI_PROTOCOL */

The dummy helpers must be 'static inline', not just 'static', otherwise you
get a warning when this header is included by a file that doesn't call
both of them.


      Arnd
