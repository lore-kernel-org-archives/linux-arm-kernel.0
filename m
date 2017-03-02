From: jeyu@redhat.com (Jessica Yu)
Date: Thu, 2 Mar 2017 17:49:57 -0500
Subject: [PATCH] module: set __jump_table alignment to 8
In-Reply-To: <f38431ab-ad33-ac14-03b5-7cb4a172be64@caviumnetworks.com>
References: <20170301220453.4756-1-david.daney@cavium.com>
 <20170302131119.6f52203f@gandalf.local.home>
 <20170302182625.GB13268@packer-debian-8-amd64.digitalocean.com>
 <f38431ab-ad33-ac14-03b5-7cb4a172be64@caviumnetworks.com>
Message-ID: <20170302224957.GC13268@packer-debian-8-amd64.digitalocean.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+++ David Daney [02/03/17 11:24 -0800]:
>On 03/02/2017 10:26 AM, Jessica Yu wrote:
>>+++ Steven Rostedt [02/03/17 13:11 -0500]:
>>>
>>>Can I get an Ack from a module maintainer?
>>
>>Acked-by: Jessica Yu <jeyu@redhat.com>
>>
>>Thanks!
>>
>>Jessica
>
>Thanks Jessica,
>
>Can you also add scripts/module-common.lds to MAINTAINERS so that 
>get_maintainers.pl will indicate that Jessica Yu and Rusty Russell be 
>CCed on things like this in the future?

Sure thing. Thanks for the heads up!

Jessica

>>>On Wed,  1 Mar 2017 14:04:53 -0800
>>>David Daney <david.daney@cavium.com> wrote:
>>>
>>>>For powerpc the __jump_table section in modules is not aligned, this
>>>>causes a WARN_ON() splat when loading a module containing a
>>>>__jump_table.
>>>>
>>>>Strict alignment became necessary with commit 3821fd35b58d
>>>>("jump_label: Reduce the size of struct static_key"), currently in
>>>>linux-next, which uses the two least significant bits of pointers to
>>>>__jump_table elements.
>>>>
>>>>Fix by forcing __jump_table to 8, which is the same alignment used for
>>>>this section in the kernel proper.
>>>>
>>>>Signed-off-by: David Daney <david.daney@cavium.com>
>>>>Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
>>>>---
>>>> scripts/module-common.lds | 2 ++
>>>> 1 file changed, 2 insertions(+)
>>>>
>>>>diff --git a/scripts/module-common.lds b/scripts/module-common.lds
>>>>index 73a2c7d..53234e8 100644
>>>>--- a/scripts/module-common.lds
>>>>+++ b/scripts/module-common.lds
>>>>@@ -19,4 +19,6 @@ SECTIONS {
>>>>
>>>>     . = ALIGN(8);
>>>>     .init_array        0 : { *(SORT(.init_array.*)) *(.init_array) }
>>>>+
>>>>+    __jump_table        0 : ALIGN(8) { KEEP(*(__jump_table)) }
>>>> }
>>>
>
