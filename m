From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 16 Mar 2018 08:38:34 +1100
Subject: linux-next: Signed-off-by missing for commit in the arm-soc tree
In-Reply-To: <CAK8P3a2-fUi0nnsLVJ6h_UuJCgwoNs2OEroYed2ofLd=FiPG0g@mail.gmail.com>
References: <20180316075629.019b6560@canb.auug.org.au>
 <CAK8P3a2-fUi0nnsLVJ6h_UuJCgwoNs2OEroYed2ofLd=FiPG0g@mail.gmail.com>
Message-ID: <20180316083834.3aa0c438@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, 15 Mar 2018 22:06:29 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>
> What script do you use to find those? I guess I should check for
> missing signoffs as well when pulling a branch.

See below.  You can give it any commit range you would give e.g. gitk.
I run this using he ranges reported by the "git fetch" for each tree
each day.
-- 
Cheers,
Stephen Rothwell

#!/bin/bash

if [ "$#" -lt 1 ]; then
	printf "Usage: %s <commit range>\n", "$0" 1>&2
	exit 1
fi

commits=$(git rev-list --no-merges "$@")
if [ -z "$commits" ]; then
	printf "No commits\n"
	exit 0
fi

for c in $commits; do
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
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180316/996e9229/attachment.sig>
