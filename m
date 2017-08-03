From: tklauser@distanz.ch (Tobias Klauser)
Date: Thu, 3 Aug 2017 11:28:27 +0200
Subject: [patch v1 1/2] drivers: jtag: Add JTAG core driver
In-Reply-To: <1501679918-20486-2-git-send-email-oleksandrs@mellanox.com>
References: <1501679918-20486-1-git-send-email-oleksandrs@mellanox.com>
 <1501679918-20486-2-git-send-email-oleksandrs@mellanox.com>
Message-ID: <20170803092826.GF3546@distanz.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nice work!

On 2017-08-02 at 15:18:37 +0200, Oleksandr Shamray <oleksandrs@mellanox.com> wrote:
> --- /dev/null
> +++ b/drivers/jtag/jtag.c
[...]
> +static int jtag_run_test_idle(struct jtag *jtag,
> +			      struct jtag_run_test_idle *idle)

Both the function and the struct it takes have the same name, which of
course is perfectly valid C. However, IMO it would be easier to grep for
the function/struct individually if they had different names.

> +{
> +	if (jtag->ops->idle)
> +		return jtag->ops->idle(jtag, idle);
> +	else
> +		return -EOPNOTSUPP;
> +}
[...]
> --- /dev/null
> +++ b/include/uapi/linux/jtag.h
> @@ -0,0 +1,133 @@
[...]
> +/**
> + * struct jtag_run_test_idle - forces JTAG sm to
> + * RUN_TEST/IDLE state *

I guess a newline is needed here to make this a valid kerneldoc comment
(the trailing '*' indicates that one was actually intended here ;)

Also, 'sm' should probably be spelled out as 'state machine'.

> + * @mode: access mode
> + * @reset: 0 - run IDEL/PAUSE from current state
> + *         1 - go trough TEST_LOGIC/RESET state before  IDEL/PAUSE

Typos: s/trough/through/ and s/IDEL/IDLE/

> + * @end: completion flag
> + * @tck: clock counter
> + *
> + * Structure represents interface to JTAG device for jtag idle
> + * execution.
> + */
> +struct jtag_run_test_idle {
> +	enum jtag_xfer_mode	mode;
> +	unsigned char		reset;
> +	enum jtag_endstate	endstate;
> +	unsigned char		tck;
> +};
