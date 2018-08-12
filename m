From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Sun, 12 Aug 2018 15:25:37 +0100
Subject: [PATCH] arm: simplify syscallnr.sh a bit
In-Reply-To: <20180812225742.594c7705@canb.auug.org.au>
References: <20180812225742.594c7705@canb.auug.org.au>
Message-ID: <20180812142537.GK6515@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 12, 2018 at 10:57:42PM +1000, Stephen Rothwell wrote:

> +nr=$(sed -n -E \
> +    's/^([[:xdigit:]Xx]+)[[:space:]]+'"${my_abis}"'[[:space:]].*$/\1/p' "$in" |
> +    sort -n | tail -n1)
> +nr=$(($nr + 1))

Alternatively,

nr=$(awk -e "/^[[:xdigit:]Xx]+[[:space:]]+${my_abis}/ {if (\$1 > max) max = \$1} \
             END {print max + 1}" "$in")

Matter of taste, of course - if that is ever get fed something so large that
use of sort + tail to find the maximum would be noticable, we are in a very
deep trouble for other reasons ;-)
