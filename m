From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 31 Aug 2017 03:21:48 +1000
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
In-Reply-To: <CAOesGMg130BvqS1vGid9jm-G7-Gub+7bOQFKtaSg4qPTvosxcA@mail.gmail.com>
References: <20170830230712.55db7911@canb.auug.org.au>
 <20170830131930.bvu6furm7dlhes3i@piout.net>
 <CAOesGMg130BvqS1vGid9jm-G7-Gub+7bOQFKtaSg4qPTvosxcA@mail.gmail.com>
Message-ID: <20170831032148.3d2fa85b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wed, 30 Aug 2017 09:21:47 -0700 Olof Johansson <olof@lixom.net> wrote:
>
> Thanks for the heads up, Stephen. I presume you have a script that
> checks this? It's something we should run too, do you keep it in a
> shared location?

Script below.

-- 
Cheers,
Stephen Rothwell

#!/bin/bash

if [ "$#" -lt 1 ]; then
	printf "Usage: %s <commit range>\n", "$0" 1>&2
	exit 1
fi

for c in $(git rev-list --no-merges "$@"); do
	ae=$(git log -1 --format='%ae' "$c")
	aE=$(git log -1 --format='%aE' "$c")
	an=$(git log -1 --format='%an' "$c")
	aN=$(git log -1 --format='%aN' "$c")
	ce=$(git log -1 --format='%ce' "$c")
	cE=$(git log -1 --format='%cE' "$c")
	cn=$(git log -1 --format='%cn' "$c")
	cN=$(git log -1 --format='%cN' "$c")
	sob=$(git log -1 --format='%b' "$c" | grep -i '^[[:space:]]*Signed-off-by:')

	am=false
	cm=false
	grep -i -q "<$ae>" <<<"$sob" ||
		grep -i -q "<$aE>" <<<"$sob" ||
		grep -i -q ":[[:space:]]*$an[[:space:]]*<" <<<"$sob" ||
		grep -i -q ":[[:space:]]*$aN[[:space:]]*<" <<<"$sob" ||
		am=true
	grep -i -q "<$ce>" <<<"$sob" ||
		grep -i -q "<$cE>" <<<"$sob" ||
		grep -i -q ":[[:space:]]*$cn[[:space:]]*<" <<<"$sob" ||
		grep -i -q ":[[:space:]]*$cN[[:space:]]*<" <<<"$sob" ||
		cm=true

	if "$am" || "$cm"; then
		printf "Commit %s\n" "$c"
		"$am" && printf "\tauthor SOB missing\n"
		"$cm" && printf "\tcommitter SOB missing\n"
		printf "%s %s\n%s\n" "$ae" "$ce" "$sob"
	fi
done

exec gitk "$@"
