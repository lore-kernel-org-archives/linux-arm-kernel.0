From: vincent.whitchurch@axis.com (Vincent Whitchurch)
Date: Mon, 19 Nov 2018 17:25:12 +0100
Subject: [PATCH 1/2] module: Overwrite st_size instead of st_info
Message-ID: <20181119162513.16562-1-vincent.whitchurch@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

st_info is currently overwritten after relocation and used to store the
elf_type().  However, we're going to need it fix kallsyms on ARM's
Thumb-2 kernels, so preserve st_info and overwrite the st_size field
instead.  st_size is neither used by the module core nor by any
architecture.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
v4: Split out to separate patch.  Use st_size instead of st_other.
v1-v3: See PATCH 2/2

 kernel/module.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 49a405891587..3d86a38b580c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2682,7 +2682,7 @@ static void add_kallsyms(struct module *mod, const struct load_info *info)
 
 	/* Set types up while we still have access to sections. */
 	for (i = 0; i < mod->kallsyms->num_symtab; i++)
-		mod->kallsyms->symtab[i].st_info
+		mod->kallsyms->symtab[i].st_size
 			= elf_type(&mod->kallsyms->symtab[i], info);
 
 	/* Now populate the cut down core kallsyms for after init. */
@@ -4061,7 +4061,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 		kallsyms = rcu_dereference_sched(mod->kallsyms);
 		if (symnum < kallsyms->num_symtab) {
 			*value = kallsyms->symtab[symnum].st_value;
-			*type = kallsyms->symtab[symnum].st_info;
+			*type = kallsyms->symtab[symnum].st_size;
 			strlcpy(name, symname(kallsyms, symnum), KSYM_NAME_LEN);
 			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
 			*exported = is_exported(name, *value, mod);
-- 
2.11.0
