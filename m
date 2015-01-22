From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jan 2015 15:27:15 +0000
Subject: [PATCH V2 1/3] perf symbols: Ignore mapping symbols on aarch64
In-Reply-To: <1421902378-3634-2-git-send-email-victor.kamensky@linaro.org>
References: <1421902378-3634-1-git-send-email-victor.kamensky@linaro.org>
 <1421902378-3634-2-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20150122152715.GZ26493@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 21, 2015 at 08:52:56PM -0800, Victor Kamensky wrote:
> Aarch64 ELF files use mapping symbols with special names $x, $d
> to identify regions of Aarch64 code (see Aarch64 ELF ABI - "ARM
> IHI 0056B", section "4.5.4 Mapping symbols").
> 
> The patch filters out these symbols at load time, similar to
> "696b97a perf symbols: Ignore mapping symbols on ARM" changes
> done for ARM before V8.

I thought I'd commented that this should probably use the same test that
we already have established elsewhere in the kernel, namely in the
kallsyms and module code:

/*
 * This ignores the intensely annoying "mapping symbols" found
 * in ARM ELF files: $a, $t and $d.
 */
static inline int is_arm_mapping_symbol(const char *str)
{ 
        return str[0] == '$' && strchr("axtd", str[1])
               && (str[2] == '\0' || str[2] == '.');
}

We really shouldn't be writing the same check for the same symbols in
different ways.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
