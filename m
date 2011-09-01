From: matt@console-pimps.org (Matt Fleming)
Date: Thu, 01 Sep 2011 10:50:03 +0100
Subject: [PATCH 09/24] C6X: signal management
In-Reply-To: <1314826019-22330-10-git-send-email-msalter@redhat.com>
References: <1314826019-22330-1-git-send-email-msalter@redhat.com>
	<1314826019-22330-10-git-send-email-msalter@redhat.com>
Message-ID: <1314870603.8038.27.camel@mfleming-mobl1.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-08-31 at 17:26 -0400, Mark Salter wrote:
> +static int setup_rt_frame(int signr, struct k_sigaction *ka, siginfo_t *info,
> +			   sigset_t *set, struct pt_regs *regs)
> +{
> +	struct rt_sigframe __user *frame;
> +	unsigned long __user *retcode;
> +	int err = 0;
> +
> +	frame = get_sigframe(ka, regs, sizeof(*frame));
> +
> +	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
> +		goto segv_and_exit;

[...]

> +segv_and_exit:
> +	force_sig(SIGSEGV, current);
> +	return -EFAULT;
> +}

Shouldn't that really be a call to force_sigsegv(signr, current) ?
