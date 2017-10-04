From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Oct 2017 12:59:54 +0200
Subject: [PATCH v3 04/22] firmware: arm_scmi: add basic driver
 infrastructure for SCMI
In-Reply-To: <1506604306-20739-5-git-send-email-sudeep.holla@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-5-git-send-email-sudeep.holla@arm.com>
Message-ID: <CAK8P3a06PM-2t4FpnMaj+57Fp6MvZ8KLo2bcLMRVCO8=K92u4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 3:11 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

> +/**
> + * struct scmi_msg_hdr - Message(Tx/Rx) header
> + *
> + * @id: The identifier of the command being sent
> + * @protocol_id: The identifier of the protocol used to send @id command
> + * @seq: The token to identify the message. when a message/command returns,
> + *       the platform returns the whole message header unmodified including
> + *      the token.
> + */
> +struct scmi_msg_hdr {
> +       u8 id;
> +       u8 protocol_id;
> +       u16 seq;
> +       u32 status;
> +       bool poll_completion;
> +};

Is this structure part of the protocol, or just part of the linux
implementation?
If this is in the protocol, you should not have a 'bool' member in there, which
does not have a well-defined binary representation across architectures.

> +/*
> + * The SCP firmware providing SCM interface to OSPM and other agents must
> + * execute only in little-endian mode as per SCMI specification, so any buffers
> + * shared through SCMI should have their contents converted to little-endian
> + */

That is a very odd thing to put into a specification, are you sure it requires
a specific runtime endian-mode? I would bet that it only requires the protocol
to use little-endian data, so better describe it like that.

> +struct scmi_shared_mem {
> +       __le32 reserved;
> +       __le32 channel_status;
> +#define SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR     BIT(1)
> +#define SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE      BIT(0)
> +       __le32 reserved1[2];
> +       __le32 flags;
> +#define SCMI_SHMEM_FLAG_INTR_ENABLED   BIT(0)
> +       __le32 length;
> +       __le32 msg_header;
> +       u8 msg_payload[0];
> +};
> +
> +static int scmi_linux_errmap[] = {
> +       /* better than switch case as long as return value is continuous */
> +       0,                      /* SCMI_SUCCESS */
> +       -EOPNOTSUPP,            /* SCMI_ERR_SUPPORT */
> +       -EINVAL,                /* SCMI_ERR_PARAM */
> +       -EACCES,                /* SCMI_ERR_ACCESS */
> +       -ENOENT,                /* SCMI_ERR_ENTRY */
> +       -ERANGE,                /* SCMI_ERR_RANGE */
> +       -EBUSY,                 /* SCMI_ERR_BUSY */
> +       -ECOMM,                 /* SCMI_ERR_COMMS */
> +       -EIO,                   /* SCMI_ERR_GENERIC */
> +       -EREMOTEIO,             /* SCMI_ERR_HARDWARE */
> +       -EPROTO,                /* SCMI_ERR_PROTOCOL */
> +};

maybe make this 'const'.

> +static struct platform_driver scmi_driver = {
> +       .driver = {
> +                  .name = "arm-scmi",
> +                  .of_match_table = of_match_ptr(scmi_of_match),
> +                  },
> +       .probe = scmi_probe,
> +       .remove = scmi_remove,
> +};

The 'of_match_ptr' annotation probably causes an 'unused variable'
warning, better just drop that.

> +#if IS_REACHABLE(CONFIG_ARM_SCMI_PROTOCOL)
> +int scmi_handle_put(const struct scmi_handle *handle);
> +const struct scmi_handle *scmi_handle_get(struct device *dev);
> +const struct scmi_handle *devm_scmi_handle_get(struct device *dev);

IS_REACHABLE() can easily lead to confusion when the driver is
a loadable module but never gets used by a built-in driver. Maybe use
IS_ENABLED() here, and add a Kconfig symbol that other drivers
can depend on if you want them to optionally use it, like:

config MAYBE_ARM_SCMI_PROTOCOL
        default y if ARM_SCMI_PROTOCOL=n
        default ARM_SCMI_PROTOCOL

     Arnd
