From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 22:24:31 +0100
Subject: [PATCH] X.509: silence asn1 compiler debug output
In-Reply-To: <2124221.xG51kBCe6s@wuerfel>
References: <2124221.xG51kBCe6s@wuerfel>
Message-ID: <2620021.MFTRTXyQbt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The asn1_compiler process is particularly chatty and produces
about the only stdout output for an allmodconfig kernel.

In order to follow the general concept of 'no news is good
news' for building kernels, this hides all the existing output
unless the KBUILD_VERBOSE environment variable is set.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
index 91c4117637ae..048f4e2aeca9 100644
--- a/scripts/asn1_compiler.c
+++ b/scripts/asn1_compiler.c
@@ -311,6 +311,9 @@ struct token {
 
 static struct token *token_list;
 static unsigned nr_tokens;
+static _Bool verbose;
+
+#define debug(args ...) ({ if (verbose) printf(args); })
 
 static int directive_compare(const void *_key, const void *_pdir)
 {
@@ -322,21 +325,21 @@ static int directive_compare(const void *_key, const void *_pdir)
 	dlen = strlen(dir);
 	clen = (dlen < token->size) ? dlen : token->size;
 
-	//printf("cmp(%*.*s,%s) = ",
+	//debug("cmp(%*.*s,%s) = ",
 	//       (int)token->size, (int)token->size, token->value,
 	//       dir);
 
 	val = memcmp(token->value, dir, clen);
 	if (val != 0) {
-		//printf("%d [cmp]\n", val);
+		//debug("%d [cmp]\n", val);
 		return val;
 	}
 
 	if (dlen == token->size) {
-		//printf("0\n");
+		//debug("0\n");
 		return 0;
 	}
-	//printf("%d\n", (int)dlen - (int)token->size);
+	//debug("%d\n", (int)dlen - (int)token->size);
 	return dlen - token->size; /* shorter -> negative */
 }
 
@@ -515,13 +518,13 @@ static void tokenise(char *buffer, char *end)
 	}
 
 	nr_tokens = tix;
-	printf("Extracted %u tokens\n", nr_tokens);
+	debug("Extracted %u tokens\n", nr_tokens);
 
 #if 0
 	{
 		int n;
 		for (n = 0; n < nr_tokens; n++)
-			printf("Token %3u: '%*.*s'\n",
+			debug("Token %3u: '%*.*s'\n",
 			       n,
 			       (int)token_list[n].size, (int)token_list[n].size,
 			       token_list[n].value);
@@ -542,6 +545,7 @@ int main(int argc, char **argv)
 	ssize_t readlen;
 	FILE *out, *hdr;
 	char *buffer, *p;
+	char *kbuild_verbose;
 	int fd;
 
 	if (argc != 4) {
@@ -550,6 +554,10 @@ int main(int argc, char **argv)
 		exit(2);
 	}
 
+	kbuild_verbose = getenv("KBUILD_VERBOSE");
+	if (kbuild_verbose)
+		verbose = atoi(kbuild_verbose);
+
 	filename = argv[1];
 	outputname = argv[2];
 	headername = argv[3];
@@ -748,11 +756,11 @@ static void build_type_list(void)
 
 	qsort(type_index, nr, sizeof(type_index[0]), type_index_compare);
 
-	printf("Extracted %u types\n", nr_types);
+	debug("Extracted %u types\n", nr_types);
 #if 0
 	for (n = 0; n < nr_types; n++) {
 		struct type *type = type_index[n];
-		printf("- %*.*s\n",
+		debug("- %*.*s\n",
 		       (int)type->name->size,
 		       (int)type->name->size,
 		       type->name->value);
@@ -793,7 +801,7 @@ static void parse(void)
 
 	} while (type++, !(type->flags & TYPE_STOP_MARKER));
 
-	printf("Extracted %u actions\n", nr_actions);
+	debug("Extracted %u actions\n", nr_actions);
 }
 
 static struct element *element_list;
@@ -1284,7 +1292,7 @@ static void render(FILE *out, FILE *hdr)
 	}
 
 	/* We do two passes - the first one calculates all the offsets */
-	printf("Pass 1\n");
+	debug("Pass 1\n");
 	nr_entries = 0;
 	root = &type_list[0];
 	render_element(NULL, root->element, NULL);
@@ -1295,7 +1303,7 @@ static void render(FILE *out, FILE *hdr)
 		e->flags &= ~ELEMENT_RENDERED;
 
 	/* And then we actually render */
-	printf("Pass 2\n");
+	debug("Pass 2\n");
 	fprintf(out, "\n");
 	fprintf(out, "static const unsigned char %s_machine[] = {\n",
 		grammar_name);
