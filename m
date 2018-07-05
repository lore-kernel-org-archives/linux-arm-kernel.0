From: joe@perches.com (Joe Perches)
Date: Thu, 05 Jul 2018 14:14:28 -0700
Subject: [PATCH] checkpatch: Add exceptions for dsb keyword usage
In-Reply-To: <1530814776-16988-1-git-send-email-pheragu@codeaurora.org>
References: <1530814776-16988-1-git-send-email-pheragu@codeaurora.org>
Message-ID: <f3ce3ca8741f774b63e8a67a278384747b1de522.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-07-05 at 11:19 -0700, Prakruthi Deepak Heragu wrote:
> mb() API can relpace the dsb() API in the kernel code. So, dsb() usage
> is discouraged. However, there are exceptions when dsb is used in a
> variable or a function name. Exceptions are when 'dsb' is prefixed with
> class [-_>*\.] and/or suffixed with class [-_\.;].
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5372,6 +5372,12 @@ sub process {
>  			     "Avoid line continuations in quoted strings\n" . $herecurr);
>  		}
>  
> +# dsb is too ARMish, and should usually be mb.
> +        if ($line =~ /[^-_>*\.]\bdsb\b[^-_\.;]/) {
> +            WARN("ARM_BARRIER",
> +                 "Use of dsb is discouranged: prefer mb.\n" .
> +                 $herecurr);
> +		}

This patch is whitespace damaged with a spelling error.

Also, if this is reasonable test, and I don't know
that it is, it should be cc'd to the linux-arm list
linux-arm-kernel at lists.infradead.org

Also, I suggest 2 tests, one for .S files and
another for .[ch] files, and this be made specific
to arch/arm... files

Something like:

	if ($realfile =~ @^arch/arm@ &&
	    ($realfile =~ /\.S$/ && $line =~ /\bdsb\b/) ||
	    ($realfile =~ /\.[ch]$/ && $line =~ /\bdsb\s*\(/)) {
		WARN("ARM_DSB",
		     "Prefer mb over dsb as an ARM memory barrier\n" . $herecurr);
	}

ARM people, is this reasonable?
