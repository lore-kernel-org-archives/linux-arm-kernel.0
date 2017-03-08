From: Stuart.Yoder@arm.com (Stuart Yoder)
Date: Wed, 8 Mar 2017 19:56:05 +0000
Subject: [PATCH v15 3/5] tee: add OP-TEE driver
In-Reply-To: <CALRxmdDNdCXztby5Kf5BUsmw8zX5+0-g9M=hjAbpUxFvVRDfJw@mail.gmail.com>
References: <1485605984-30064-1-git-send-email-jens.wiklander@linaro.org>
 <1485605984-30064-4-git-send-email-jens.wiklander@linaro.org>
 <CALRxmdDNdCXztby5Kf5BUsmw8zX5+0-g9M=hjAbpUxFvVRDfJw@mail.gmail.com>
Message-ID: <4C0FFCAE-756B-4432-9791-290337A2F5AA@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[cut]
> +static struct optee *optee_probe(struct device_node *np)
> +{
> +       optee_invoke_fn *invoke_fn;
> +       struct tee_shm_pool *pool;
> +       struct optee *optee = NULL;
> +       void *memremaped_shm = NULL;
> +       struct tee_device *teedev;
> +       u32 sec_caps;
> +       int rc;
> +
> +       invoke_fn = get_invoke_func(np);
> +       if (IS_ERR(invoke_fn))
> +               return (void *)invoke_fn;
> +
> +       if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
> +               pr_warn("api uid mismatch\n");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       if (!optee_msg_api_revision_is_compatible(invoke_fn)) {
> +               pr_warn("api revision mismatch\n");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps)) {
> +               pr_warn("capabilities mismatch\n");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       /*
> +        * We have no other option for shared memory, if secure world
> +        * doesn't have any reserved memory we can use we can't continue.
> +        */
> +       if (!(sec_caps & OPTEE_SMC_SEC_CAP_HAVE_RESERVERED_SHM))
> +               return ERR_PTR(-EINVAL);

Typo?  RESERVERED_SHM should be RESERVED_SHM

> diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> +/*
> + * Exchanges capabilities between normal world and secure world
> + *
> + * Call register usage:
> + * a0  SMC Function ID, OPTEE_SMC_EXCHANGE_CAPABILITIES
> + * a1  bitfield of normal world capabilities OPTEE_SMC_NSEC_CAP_*
> + * a2-6        Not used
> + * a7  Hypervisor Client ID register
> + *
> + * Normal return register usage:
> + * a0  OPTEE_SMC_RETURN_OK
> + * a1  bitfield of secure world capabilities OPTEE_SMC_SEC_CAP_*
> + * a2-7        Preserved
> + *
> + * Error return register usage:
> + * a0  OPTEE_SMC_RETURN_ENOTAVAIL, can't use the capabilities from normal world
> + * a1  bitfield of secure world capabilities OPTEE_SMC_SEC_CAP_*
> + * a2-7 Preserved
> + */
> +/* Normal world works as a uniprocessor system */
> +#define OPTEE_SMC_NSEC_CAP_UNIPROCESSOR                BIT(0)
> +/* Secure world has reserved shared memory for normal world to use */
> +#define OPTEE_SMC_SEC_CAP_HAVE_RESERVERED_SHM  BIT(0)

Same typo?  s/RESERVERED_SHM/RESERVED_SHM/

Thanks,
Stuart


IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
