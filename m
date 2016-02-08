From: arnd@arndb.de (Arnd Bergmann)
Date: Mon,  8 Feb 2016 15:36:52 +0100
Subject: [PATCH] locking/static_keys: avoid nested functions
Message-ID: <1454942223-2781480-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clang does not support nested functions inside of an array definition:

lib/test_static_keys.c:105:16: error: function definition is not allowed here
                        .test_key       = test_key_func(&old_true_key, static_key_true),
lib/test_static_keys.c:50:20: note: expanded from macro 'test_key_func'
        ({bool func(void) { return branch(key); } func; })

That code appears to have been a little too clever, so this
simplifies it a bit by defining functions outside of the array.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/test_static_keys.c | 62 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/lib/test_static_keys.c b/lib/test_static_keys.c
index c61b299e367f..915d75df2086 100644
--- a/lib/test_static_keys.c
+++ b/lib/test_static_keys.c
@@ -46,8 +46,11 @@ struct test_key {
 	bool			(*test_key)(void);
 };
 
-#define test_key_func(key, branch) \
-	({bool func(void) { return branch(key); } func;	})
+#define test_key_func(key, branch)	\
+static bool key ## _ ## branch(void)	\
+{					\
+	return branch(&key);		\
+}
 
 static void invert_key(struct static_key *key)
 {
@@ -92,6 +95,25 @@ static int verify_keys(struct test_key *keys, int size, bool invert)
 	return 0;
 }
 
+test_key_func(old_true_key, static_key_true)
+test_key_func(old_false_key, static_key_false)
+test_key_func(true_key, static_branch_likely)
+test_key_func(true_key, static_branch_unlikely)
+test_key_func(false_key, static_branch_likely)
+test_key_func(false_key, static_branch_unlikely)
+test_key_func(base_old_true_key, static_key_true)
+test_key_func(base_inv_old_true_key, static_key_true)
+test_key_func(base_old_false_key, static_key_false)
+test_key_func(base_inv_old_false_key, static_key_false)
+test_key_func(base_true_key, static_branch_likely)
+test_key_func(base_true_key, static_branch_unlikely)
+test_key_func(base_inv_true_key, static_branch_likely)
+test_key_func(base_inv_true_key, static_branch_unlikely)
+test_key_func(base_false_key, static_branch_likely)
+test_key_func(base_false_key, static_branch_unlikely)
+test_key_func(base_inv_false_key, static_branch_likely)
+test_key_func(base_inv_false_key, static_branch_unlikely)
+
 static int __init test_static_key_init(void)
 {
 	int ret;
@@ -102,95 +124,95 @@ static int __init test_static_key_init(void)
 		{
 			.init_state	= true,
 			.key		= &old_true_key,
-			.test_key	= test_key_func(&old_true_key, static_key_true),
+			.test_key	= &old_true_key_static_key_true,
 		},
 		{
 			.init_state	= false,
 			.key		= &old_false_key,
-			.test_key	= test_key_func(&old_false_key, static_key_false),
+			.test_key	= &old_false_key_static_key_false,
 		},
 		/* internal keys - new keys */
 		{
 			.init_state	= true,
 			.key		= &true_key.key,
-			.test_key	= test_key_func(&true_key, static_branch_likely),
+			.test_key	= &true_key_static_branch_likely,
 		},
 		{
 			.init_state	= true,
 			.key		= &true_key.key,
-			.test_key	= test_key_func(&true_key, static_branch_unlikely),
+			.test_key	= &true_key_static_branch_unlikely,
 		},
 		{
 			.init_state	= false,
 			.key		= &false_key.key,
-			.test_key	= test_key_func(&false_key, static_branch_likely),
+			.test_key	= &false_key_static_branch_likely,
 		},
 		{
 			.init_state	= false,
 			.key		= &false_key.key,
-			.test_key	= test_key_func(&false_key, static_branch_unlikely),
+			.test_key	= &false_key_static_branch_unlikely,
 		},
 		/* external keys - old keys */
 		{
 			.init_state	= true,
 			.key		= &base_old_true_key,
-			.test_key	= test_key_func(&base_old_true_key, static_key_true),
+			.test_key	= &base_old_true_key_static_key_true,
 		},
 		{
 			.init_state	= false,
 			.key		= &base_inv_old_true_key,
-			.test_key	= test_key_func(&base_inv_old_true_key, static_key_true),
+			.test_key	= &base_inv_old_true_key_static_key_true,
 		},
 		{
 			.init_state	= false,
 			.key		= &base_old_false_key,
-			.test_key	= test_key_func(&base_old_false_key, static_key_false),
+			.test_key	= &base_old_false_key_static_key_false,
 		},
 		{
 			.init_state	= true,
 			.key		= &base_inv_old_false_key,
-			.test_key	= test_key_func(&base_inv_old_false_key, static_key_false),
+			.test_key	= &base_inv_old_false_key_static_key_false,
 		},
 		/* external keys - new keys */
 		{
 			.init_state	= true,
 			.key		= &base_true_key.key,
-			.test_key	= test_key_func(&base_true_key, static_branch_likely),
+			.test_key	= &base_true_key_static_branch_likely,
 		},
 		{
 			.init_state	= true,
 			.key		= &base_true_key.key,
-			.test_key	= test_key_func(&base_true_key, static_branch_unlikely),
+			.test_key	= &base_true_key_static_branch_unlikely,
 		},
 		{
 			.init_state	= false,
 			.key		= &base_inv_true_key.key,
-			.test_key	= test_key_func(&base_inv_true_key, static_branch_likely),
+			.test_key	= &base_inv_true_key_static_branch_likely,
 		},
 		{
 			.init_state	= false,
 			.key		= &base_inv_true_key.key,
-			.test_key	= test_key_func(&base_inv_true_key, static_branch_unlikely),
+			.test_key	= &base_inv_true_key_static_branch_unlikely,
 		},
 		{
 			.init_state	= false,
 			.key		= &base_false_key.key,
-			.test_key	= test_key_func(&base_false_key, static_branch_likely),
+			.test_key	= &base_false_key_static_branch_likely,
 		},
 		{
 			.init_state	= false,
 			.key		= &base_false_key.key,
-			.test_key	= test_key_func(&base_false_key, static_branch_unlikely),
+			.test_key	= &base_false_key_static_branch_unlikely,
 		},
 		{
 			.init_state	= true,
 			.key		= &base_inv_false_key.key,
-			.test_key	= test_key_func(&base_inv_false_key, static_branch_likely),
+			.test_key	= &base_inv_false_key_static_branch_likely,
 		},
 		{
 			.init_state	= true,
 			.key		= &base_inv_false_key.key,
-			.test_key	= test_key_func(&base_inv_false_key, static_branch_unlikely),
+			.test_key	= &base_inv_false_key_static_branch_unlikely,
 		},
 	};
 
-- 
2.7.0
