From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 Aug 2016 18:26:31 +0100
Subject: [PATCH 1/2] jump_labels: Allow array initialisers
In-Reply-To: <1472145992-10660-1-git-send-email-catalin.marinas@arm.com>
References: <1472145992-10660-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1472145992-10660-2-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The static key API is currently designed around single variable
definitions. There are cases where an array of static keys is desirable,
so extend the API to allow this rather than using the internal static
key implementation directly.

Suggested-by: Dave P Martin <Dave.Martin@arm.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/static-keys.txt |  8 ++++++++
 include/linux/jump_label.h    | 12 ++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/static-keys.txt b/Documentation/static-keys.txt
index 477927becacb..fd490f8b1cfa 100644
--- a/Documentation/static-keys.txt
+++ b/Documentation/static-keys.txt
@@ -15,6 +15,8 @@ The updated API replacements are:
 
 DEFINE_STATIC_KEY_TRUE(key);
 DEFINE_STATIC_KEY_FALSE(key);
+DEFINE_STATIC_KEY_ARRAY_TRUE(keys, count);
+DEFINE_STATIC_KEY_ARRAY_FALSE(keys, count);
 static_branch_likely()
 static_branch_unlikely()
 
@@ -140,6 +142,12 @@ static_branch_inc(), will change the branch back to true. Likewise, if the
 key is initialized false, a 'static_branch_inc()', will change the branch to
 true. And then a 'static_branch_dec()', will again make the branch false.
 
+Where an array of keys is required, it can be defined as:
+
+	DEFINE_STATIC_KEY_ARRAY_TRUE(keys, count);
+
+or:
+	DEFINE_STATIC_KEY_ARRAY_FALSE(keys, count);
 
 4) Architecture level code patching interface, 'jump labels'
 
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 661af564fae8..a534c7f15a61 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -21,6 +21,8 @@
  *
  * DEFINE_STATIC_KEY_TRUE(key);
  * DEFINE_STATIC_KEY_FALSE(key);
+ * DEFINE_STATIC_KEY_ARRAY_TRUE(keys, count);
+ * DEFINE_STATIC_KEY_ARRAY_FALSE(keys, count);
  * static_branch_likely()
  * static_branch_unlikely()
  *
@@ -270,6 +272,16 @@ struct static_key_false {
 #define DEFINE_STATIC_KEY_FALSE(name)	\
 	struct static_key_false name = STATIC_KEY_FALSE_INIT
 
+#define DEFINE_STATIC_KEY_ARRAY_TRUE(name, count)		\
+	struct static_key_true name[count] = {			\
+		[0 ... (count) - 1] = STATIC_KEY_TRUE_INIT,	\
+	}
+
+#define DEFINE_STATIC_KEY_ARRAY_FALSE(name, count)		\
+	struct static_key_false name[count] = {			\
+		[0 ... (count) - 1] = STATIC_KEY_FALSE_INIT,	\
+	}
+
 extern bool ____wrong_branch_error(void);
 
 #define static_key_enabled(x)							\
